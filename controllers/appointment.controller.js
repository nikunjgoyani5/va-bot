import Appointment from "../models/appointment.model.js";
import { StatusCodes } from "http-status-codes";
import config from "../config/config.js";
import helper from "../services/file.upload.service.js";
import { google } from "googleapis";
import oauth2Client from "../config/googleclient.config.js";
import User from "../models/user.model.js";
import calenderController from "./calendar.controller.js";
import enums from "../config/enum.config.js";
import { apiResponse } from "../helper/api-response.helper.js";
import calenderService from "../services/calender-event.service.js";
import activityService from "../services/activity-track.service.js";

// Task complated - APIs properly logging events and create activity log's

//Create an appointment
const createAppointment = async (req, res) => {
  try {
    let fileUrl = null;

    if (req.file)  fileUrl = await helper.uploadFile(req.file, config.bucketStorageFolders.APPOINTMENT);

    let clientData;
    try {
      clientData = JSON.parse(req.body.client);
    } catch (error) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        status: false,
        message: "Invalid client data format",
      });
    }

    const appointment = new Appointment({
      ...req.body,
      startTime: req.body.startTime,
      endTime: req.body.endTime,
      expiredAt: new Date(req.body.endTime),
      client: clientData,
      image: fileUrl,
    });

    await appointment.save();

    await activityService.createActivity({
      userId: req.user.id,
      email: req.user.email,
      category: enums.acvityCategoryTypeEnum.APPOINTMENT,
      activityType: enums.activityTypeEnum.APPOINTMENT_CREATE,
      activityData: appointment,
      status : true,
      error: "",
      errorMessage: ""
    })

    // Create event in Google Calendar
    const user = await User.findById(req.user.id);
    if (user && user.integrations && user.integrations.googleCalendar && user.integrations.googleCalendar.calendarId) {
      try {
        const accessToken = await calenderController.getAccessToken(req.user.id);
        oauth2Client.setCredentials({ access_token: accessToken }); 

        // Create the event in Google Calendar
        const calendarEvent = await calenderService.createCalenderEvent(appointment, accessToken, user.integrations.googleCalendar.calendarId,enums.calenderTypeEnum.GOOGLE);
        await Appointment.findByIdAndUpdate(appointment._id, { $set: { googleCalendarId: calendarEvent.id } });

      } catch (error) {
        return apiResponse({
          res,
          statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
          status: false,
          message: "Failed to create google event " + error.message,
        });
      }
    }

    // Create event in Outlook Calendar
    if (user && user.integrations && user.integrations.outlookCalendar && user.integrations.outlookCalendar.calendarId) {
      try {
        const userId = req.user.id;
        const user = await User.findById(userId);
        const accessToken = await calenderService.getValidMicrosoftAccessToken(user);

        const outlookEventResponse = await calenderService.createCalenderEvent(appointment, accessToken, user.integrations.outlookCalendar.calendarId,enums.calenderTypeEnum.OUTLOOK);
        await Appointment.findByIdAndUpdate(appointment._id, { $set: { outlookCalendarId: outlookEventResponse.id } });
      } catch (error) {
        return apiResponse({
          res,
          statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
          status: false,
          message: "Failed to create outlook event " + error.message,
        });
      }
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.CREATED,
      status: true,
      message: "Appointment created successfully",
      data: appointment,
    });
  } catch (error) {
    console.log(error)
    await activityService.createActivity({
      userId: req.user.id,
      email: req.user.email,
      category: enums.acvityCategoryTypeEnum.APPOINTMENT,
      activityType: enums.activityTypeEnum.APPOINTMENT_CREATE,
      description: "Appoinment Creation Failed",
      status : false,
      error: error,
      errorMessage: error.message
    })

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Error creating appointment",
      error: error.message,
    });
  }
};

// Get all appointments
const getAppointments = async (req, res) => {
  try {
    const appointments = await Appointment.find();
    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      data: appointments,
    });
  } catch (error) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Error fetching appointments",
      error: error.message,
    });
  }
};

//Cancel an appointment (Allowed for "pending" or "rescheduled")
const cancelAppointment = async (req, res) => {
  try {
    const { id } = req.params;
    const appointment = await Appointment.findById(id);

    if (!appointment) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        status: false,
        message: "Appointment not found",
      });
    }

    if (appointment.status !== enums.appointmentStatusEnum.PENDING && appointment.status !== enums.appointmentStatusEnum.RESCHEDULED) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        status: false,
        message: "Only pending or rescheduled appointments can be cancelled",
      });
    }

    appointment.status = enums.appointmentStatusEnum.CANCELLED;
    await appointment.save();

    await activityService.createActivity({
      userId: req.user.id,
      email: req.user.email,
      category: enums.acvityCategoryTypeEnum.APPOINTMENT,
      activityType: enums.activityTypeEnum.APPOINTMENT_CANCEL,
      description: "Appoinment Cancelled Successfully",
      activityData: appointment,
      status : true,
      error: "",
      errorMessage: ""
    })

    // Update Google Calendar event if exists
    if (appointment.googleCalendarId) {
      try {
        const user = await User.findById(req.user.id);
        const accessToken = await calenderController.getAccessToken(req.user.id);
        oauth2Client.setCredentials({ access_token: accessToken });
        const calendar = google.calendar({ version: "v3", auth: oauth2Client });

        const event = await calendar.events.get({
          calendarId: user.integrations.googleCalendar.calendarId,
          eventId: appointment.googleCalendarId
        });

        event.data.description = `Status: ${appointment.status.toUpperCase()}\nAppointment Type: ${appointment.appointmentType}\nNotes: ${appointment.notes || "No additional notes"}`;

        await calendar.events.update({
          calendarId: user.integrations.googleCalendar.calendarId,
          eventId: appointment.googleCalendarId,
          resource: event.data
        });
      } catch (error) {
        return apiResponse({
          res,
          statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
          status: false,
          message: "Failed to cancel google event " + error.message,
        });
      }
    }

    if (appointment.outlookCalendarId) {
      try {
        const user = await User.findById(req.user.id);
        const accessToken = await calenderService.getValidMicrosoftAccessToken(user);
        await calenderService.updateCalenderEvent(appointment, appointment.outlookCalendarId, accessToken, user.integrations.outlookCalendar.calendarId);
      } catch (error) {
        return apiResponse({
          res,
          statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
          status: false,
          message: "Failed to cancel outlook event " + error.message,
        });
      }
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "Appointment cancelled successfully",
      data: appointment,
    });
  } catch (error) {

    await activityService.createActivity({
      userId: req.user.id,
      email: req.user.email,
      category: enums.acvityCategoryTypeEnum.APPOINTMENT,
      activityType: enums.activityTypeEnum.APPOINTMENT_CANCEL,
      description: "Appoinment Cancelled Failed",
      status : false,
      error: error,
      errorMessage: error.message
    })
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Error cancelling appointment",
      error: error.message,
    });
  }
};

//Reschedule an appointment (Allowed for "pending", "cancelled", "rescheduled", "missed")
const rescheduleAppointment = async (req, res) => {
  try {
    const { id } = req.params;
    const { newStartTime, newEndTime } = req.body;
    console.log(newStartTime , "newStartTime");
    console.log(newEndTime , "newEndTime");
    const startTime = new Date(newStartTime);
    const endTime = new Date(newEndTime);

    const appointment = await Appointment.findById(id);

    if (!appointment) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        status: false,
        message: "Appointment not found",
      });
    }

    if (appointment.status === enums.appointmentStatusEnum.MISSED || appointment.status === enums.appointmentStatusEnum.CANCELLED || appointment.status === enums.appointmentStatusEnum.RESCHEDULED || appointment.status === enums.appointmentStatusEnum.PENDING) {
      appointment.startTime = startTime;
      appointment.endTime = endTime;
      appointment.rescheduledFrom = appointment.startTime;
      appointment.status = enums.appointmentStatusEnum.RESCHEDULED;
      await appointment.save();

      await activityService.createActivity({
        userId: req.user.id,
        email: req.user.email,
        category: enums.acvityCategoryTypeEnum.APPOINTMENT,
        activityType: enums.activityTypeEnum.APPOINTMENT_RESCHEDULE,
        description: "Appoinment Rescheduled Successfully",
        activityData: appointment,
        status : true,
        error: "",
        errorMessage: ""
      })

      // Update Google Calendar event if exists
      if (appointment.googleCalendarId) {
        try {
          const user = await User.findById(req.user.id);
          const accessToken = await calenderController.getAccessToken(req.user.id);
          oauth2Client.setCredentials({ access_token: accessToken });
          const calendar = google.calendar({ version: "v3", auth: oauth2Client });

          const event = await calendar.events.get({
            calendarId: user.integrations.googleCalendar.calendarId,
            eventId: appointment.googleCalendarId
          });

          event.data.start = {
            dateTime: newStartTime,
            timeZone: "America/Los_Angeles"
          };
          event.data.end = {
            dateTime: newEndTime,
            timeZone: "America/Los_Angeles"
          };
          event.data.description = `Status: ${appointment.status.toUpperCase()}\nAppointment Type: ${appointment.appointmentType}\nNotes: ${appointment.notes || "No additional notes"}`;

          await calendar.events.update({
            calendarId: user.integrations.googleCalendar.calendarId,
            eventId: appointment.googleCalendarId,
            resource: event.data
          });
        } catch (error) {
          return apiResponse({
            res,
            statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
            status: false,
            message: "Failed to update event" + error.message,
          });
        }
      }

      if (appointment.outlookCalendarId) {
        try {
          const user = await User.findById(req.user.id);
          const accessToken = await calenderService.getValidMicrosoftAccessToken(user);
          await calenderController.updateOutlookEvent(appointment, appointment.outlookCalendarId,accessToken, user.integrations.outlookCalendar.calendarId);
        } catch (error) {
          return apiResponse({
            res,
            statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
            status: false,
            message: "Failed to update outlook event " + error.message,
          });
        }
      }

      return apiResponse({
        res,
        statusCode: StatusCodes.OK,
        status: true,
        message: "Appointment rescheduled successfully",
        data: appointment,
      });
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.BAD_REQUEST,
      status: false,
      message: "Appointment cannot be rescheduled from this status",
    });

  } catch (error) {

    await activityService.createActivity({
      userId: req.user.id,
      email: req.user.email,
      category: enums.acvityCategoryTypeEnum.APPOINTMENT,
      activityType: enums.activityTypeEnum.APPOINTMENT_RESCHEDULE,
      description: "Appoinment Rescheduled Failed",
      status : false,
      error: error,
      errorMessage: error.message
    })

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Error rescheduling appointment",
      error: error.message,
    });
  }
};

export default { 
  createAppointment, 
  getAppointments, 
  cancelAppointment, 
  rescheduleAppointment, 
};
