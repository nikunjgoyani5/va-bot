import Appointment from "../models/appointment.model.js";
import User from "../models/user.model.js";
import { google } from "googleapis";
import oauth2Client from "../config/googleclient.config.js";
import config from "../config/config.js";
import enums from "../config/enum.config.js";
import { apiResponse } from "../helper/api-response.helper.js";
import { StatusCodes } from "http-status-codes";
import axios from "axios"

const getMicrosoftAccessToken = async (code) => {
    try {
        const params = new URLSearchParams();
        params.append("client_id", config.outlook.clientId);
        params.append("client_secret", config.outlook.clientSecret);
        params.append("redirect_uri", config.outlook.redirectUri);
        params.append("grant_type", "authorization_code");
        params.append("code", code);

        const response = await axios.post(config.outlook.tokenUrl, params, {
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
        });
        return response.data;
    } catch (error) {
        return apiResponse({
            statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
            status: false,
            message: "Failed to get Outlook access token",
            error: error.message
        });
    }
}

const refreshMicrosoftAccessToken = async (refreshToken) => {
    try {
        const params = new URLSearchParams();
        params.append("client_id", config.outlook.clientId);
        params.append("client_secret", config.outlook.clientSecret);
        params.append("refresh_token", refreshToken);
        params.append("grant_type", "refresh_token");

        const response = await axios.post(config.outlook.tokenUrl, params, {
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
        });

        return response.data;
    } catch (error) {
        return apiResponse({
            statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
            status: false,
            message: "Failed to refresh Outlook access token",
            error: error.message
        });
    }
}

const getValidMicrosoftAccessToken = async (user) => {
    try {
        await axios.get(`${config.outlook.graphUrl}`, {
            headers: { Authorization: `Bearer ${user.outlookAccounts[0].accessToken}` },
        });

        return user.outlookAccounts[0].accessToken;
    } catch (error) {
        if (error.response && error.response.status === 401) {
            const newTokens = await refreshMicrosoftAccessToken(user.outlookAccounts[0].refreshToken);
            user.outlookAccounts[0].accessToken = newTokens.access_token;
            user.outlookAccounts[0].refreshToken = newTokens.refresh_token; 
            user.outlookAccounts[0].expiresIn = newTokens.expires_in;
            await user.save();
            return newTokens.access_token;
        }
        throw error;
    }
}

const createCalenderEvent = async (appointment, accessToken, calendarId, type) => {
    try {
        if (type === enums.calenderTypeEnum.GOOGLE) {
            console.log("created from google service")
            try {
                oauth2Client.setCredentials({ access_token: accessToken });
                const calendar = google.calendar({ version: "v3", auth: oauth2Client });

                const startTime = new Date(appointment.startTime);
                const endTime = new Date(appointment.endTime);

                const event = {
                    summary: `Appointment: ${appointment.client.name}`,
                    location: appointment.propertyAddress || "Online",
                    description: `Status: ${appointment.status.toUpperCase()}\nAppointment Type: ${appointment.appointmentType}\nNotes: ${appointment.notes || "No additional notes"}`,
                    start: {
                        dateTime: startTime,
                        timeZone: "America/Los_Angeles"
                    },
                    end: {
                        dateTime: endTime,
                        timeZone: "America/Los_Angeles"
                    },
                    reminders: {
                        useDefault: false,
                        overrides: [
                            { method: 'email', minutes: 60 },
                            { method: 'popup', minutes: 30 }
                        ]
                    }
                };

                if (appointment.client.email) {
                    event.attendees = [{ email: appointment.client.email }];
                }

                if (appointment.image) {
                    event.attachments = [{
                        fileUrl: appointment.image,
                        title: "Appointment Image"
                    }];
                }

                const response = await calendar.events.insert({
                    calendarId: calendarId,
                    resource: event,
                    sendNotifications: true
                })

                return response.data;
            } catch (error) {
                console.error("Google Calendar Error:", error);
                return apiResponse({
                    res,
                    statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
                    message: "Failed to create google calendar event",
                    status: false,
                    data: { error: error.message },
                });
            }
        }
        else if (type === enums.calenderTypeEnum.OUTLOOK) {
            try {
                console.log("created from outlook service")
                const startDate = new Date(appointment.startTime);
                const endDate = new Date(appointment.endTime);

                const outlookEvent = {
                    subject: `Appointment: ${appointment.client.name}`,
                    body: {
                        contentType: "HTML",
                        content: `<p><strong>Status:</strong> ${appointment.status.toUpperCase()}<br />
                                 <strong>Appointment Type:</strong> ${appointment.appointmentType}<br />
                                 <strong>Notes:</strong> ${appointment.notes || "No additional notes"}</p>`
                    },
                    start: {
                        dateTime: startDate.toISOString(),
                        timeZone: "UTC"
                    },
                    end: {
                        dateTime: endDate.toISOString(),
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

                const response = await axios.post(`${config.outlook.graphUrl}/calendars/${calendarId}/events`, outlookEvent, {
                    headers: {
                        Authorization: `Bearer ${accessToken}`,
                        "Content-Type": "application/json"
                    }
                })

                return response.data;
            } catch (error) {
                console.error("Outlook Calendar Error:", error.message);
                return apiResponse({
                    statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
                    status: false,
                    message: "Failed to create outlook event" + error.message,
                });
            } 
        }
    } catch (error) {
        await apiResponse({
            statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
            status: false,
            message: "Failed to create event" + error.message,
        });
    }
}

const updateCalenderEvent = async (appointment, eventId, accessToken, calendarId) => {
    try {
        console.log("updated from google service")
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
    getMicrosoftAccessToken,
    refreshMicrosoftAccessToken,
    getValidMicrosoftAccessToken,
    createCalenderEvent,
    updateCalenderEvent
}