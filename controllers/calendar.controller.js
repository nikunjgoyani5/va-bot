import { google } from "googleapis";
import oauth2Client from "../config/googleclient.config.js";
import { StatusCodes } from "http-status-codes";
import { apiResponse } from "../helper/api-response.helper.js";
import User from "../models/user.model.js";
import axios from "axios";
import config from "../config/config.js";

// ----------------------------------- google calendar -----------------------------------
const getAccessToken = async (userId) => {
  const user = await User.findById(userId);

  if (!user || !user.refreshToken)
    throw new Error("please complate google authentication first");

  oauth2Client.setCredentials({ refresh_token: user.refreshToken });
  const { token } = await oauth2Client.getAccessToken();

  return token;
};

const createGoogleCalendar = async (req, res) => {
  try {
    const user = await User.findById(req.user.id);
    const accessToken = await getAccessToken(req.user.id);
    oauth2Client.setCredentials({ access_token: accessToken });

    const calendar = google.calendar({ version: "v3", auth: oauth2Client });

    const response = await calendar.calendars.insert({
      requestBody: { summary: `User ${user.firstName} Calendar` },
    });

    await User.findByIdAndUpdate(req.user.id, { $set: { "integrations.googleCalendar.calendarId": response.data.id, "integrations.googleCalendar.enabled": true } });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "New Calendar Created Successfully.",
      status: true,
      data: { calendarId: response.data.id },
    });
  } catch (error) {
    console.error("Google Calendar Error:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to create calendar",
      status: false,
      data: { error: error.message },
    });
  }
};

// ----------------------------------- outlook calendar -----------------------------------

// get outlook calendar access token from refresh token
// const getOutlookAccessToken = async (userId) => {
//   try {
//     const user = await User.findById(userId);
//     if (!user || !user.outlookAccounts || !user.outlookAccounts[0]) {
//       return apiResponse({
//         statusCode: StatusCodes.NOT_FOUND,
//         status: false,
//         message: "User or Outlook account not found",
//       });
//     }

//     const currentAccessToken = user.outlookAccounts[0].accessToken;
//     try {
//       await axios.get(`${config.outlook.graphUrl}`, {
//         headers: { Authorization: `Bearer ${currentAccessToken}` }
//       });
//       return currentAccessToken;
//     } catch (error) {
//       if (error.response?.status !== 401) {
//         return apiResponse({
//           res,
//           statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
//           status: false,
//           message: "Failed to get valid Outlook access token",
//           error: error.message
//         });
//       }
//     }
//     console.log(currentAccessToken , "currentAccessToken");

//     const refreshToken = user.outlookAccounts[0].refreshToken;
//     const clientId = config.outlook.clientId;
//     const clientSecret = config.outlook.clientSecret;

//     const authUrl = `${config.outlook.tokenUrl}`;
//     const response = await axios.post(authUrl, {
//       client_id: clientId,
//       client_secret: clientSecret,
//       refresh_token: refreshToken,
//       grant_type: 'refresh_token'
//     });

//     console.log(response , "response");

//     // Update user document with new tokens
//     user.outlookAccounts[0].accessToken = response.data.access_token;
//     user.outlookAccounts[0].refreshToken = response.data.refresh_token || refreshToken;
//     await user.save();

//     return response.data.access_token;
//   } catch (error) {
//     console.error('Error in getOutlookAccessToken:', error);
//     return apiResponse({
//       statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
//       status: false,
//       message: "Failed to get valid Outlook access token",
//       error: error.message
//     });

//   }
// }

const createOutlookCalendar = async (req, res) => {
  try {
    const userId = req.user.id;
    const user = await User.findById(userId);

    if (!user || !user.outlookAccounts[0].accessToken || !user.outlookAccounts[0].refreshToken) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "Please complete Outlook authentication first",
        status: false,
      });
    }

    // First try to get existing calendars
    const existingCalendars = await axios.get(`${config.outlook.graphUrl}/calendars`, {
      headers: {
        'Authorization': `Bearer ${user.outlookAccounts[0].accessToken}`,
        'Content-Type': 'application/json'
      }
    });

    // Check if calendar already exists
    const calendarName = `User ${user.firstName} Calendar`;
    const existingCalendar = existingCalendars.data.value.find(cal => cal.name === calendarName);

    if (existingCalendar) {
      // If calendar exists, use that
      await User.findByIdAndUpdate(userId, {
        $set: {
          "integrations.outlookCalendar.calendarId": existingCalendar.id,
          "integrations.outlookCalendar.enabled": true
        }
      });

      return apiResponse({
        res,
        statusCode: StatusCodes.OK,
        message: "Existing Outlook Calendar connected successfully",
        status: true,
        data: { calendarId: existingCalendar.id },
      });
    }

    // If calendar doesn't exist, create new one
    const calendarData = {
      name: calendarName,
      color: "lightBlue"
    };

    const calendarResponse = await axios.post(
      `${config.outlook.graphUrl}/calendars`,
      calendarData,
      {
        headers: {
          'Authorization': `Bearer ${user.outlookAccounts[0].accessToken}`,
          'Content-Type': 'application/json',
          'Prefer': 'outlook.timezone="UTC"'
        }
      }
    );

    await User.findByIdAndUpdate(userId, {
      $set: {
        "integrations.outlookCalendar.calendarId": calendarResponse.data.id,
        "integrations.outlookCalendar.enabled": true
      }
    });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "New Outlook Calendar created successfully",
      status: true,
      data: { calendarId: calendarResponse.data.id },
    });

  } catch (error) {
    console.error("Outlook Calendar Error Details:", {
      message: error.message,
      response: error.response?.data,
      status: error.response?.status
    });

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Failed to create/connect Outlook calendar: " + (error.response?.data?.error?.message || error.message),
    });
  }
}

const updateOutlookEvent = async (appointment, eventId, accessToken, calendarId) => {
  try {
    // Convert dates to ISO string format
    const startDateTime = new Date(appointment.startTime);
    const endDateTime = new Date(appointment.endTime);

    const outlookEvent = {
      subject: `Appointment: ${appointment.client.name}`,
      body: {
        contentType: "HTML",
        content: `<p><strong>Status:</strong> ${appointment.status.toUpperCase()}<br />
                 <strong>Appointment Type:</strong> ${appointment.appointmentType}<br />
                 <strong>Notes:</strong> ${appointment.notes || "No additional notes"}</p>`
      },
      start: {
        dateTime: startDateTime.toISOString(),
        timeZone: "UTC"
      },
      end: {
        dateTime: endDateTime.toISOString(),
        timeZone: "UTC"
      },
      location: {
        displayName: appointment.propertyAddress || "Online"
      },
      attendees: appointment.client.email ? [
        {
          emailAddress: {
            address: appointment.client.email,
            name: appointment.client.name
          },
          type: "required"
        }
      ] : [],
      isReminderOn: true,
      reminderMinutesBeforeStart: 30,
      allowNewTimeProposals: true,
      importance: "normal",
      sensitivity: "normal",
      showAs: "busy"
    };

    const response = await axios.patch(
      `${config.outlook.graphUrl}/calendars/${calendarId}/events/${eventId}`,
      outlookEvent,
      {
        headers: {
          'Authorization': `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
          'Prefer': 'outlook.timezone="America/Los_Angeles"'
        }
      }
    );

    return response.data;
  } catch (error) {
    console.error("Outlook Calendar Error:", error.response?.data || error.message);
    // throw new Error(error.response?.data?.error?.message || error.message);
    return apiResponse({
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Failed to update event" + error.message,
    });
  }
}

export default {
  createGoogleCalendar,
  getAccessToken,
  // getOutlookAccessToken,
  createOutlookCalendar,
  updateOutlookEvent
};