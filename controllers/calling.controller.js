import twilioPkg from "twilio";
import config from "../config/config.js";
import { apiResponse } from "../helper/api-response.helper.js";
import { StatusCodes } from "http-status-codes";

const twilioClient = twilioPkg(config.twilio.accountSid, config.twilio.authToken);

const handleIncomingCall = (req, res) => {
    try {
      const response = new twilioPkg.twiml.VoiceResponse();
      response.say("Welcome! Recording will start now.");
      response.record({ maxLength: 60, playBeep: true, trim: "trim-silence" });
      response.say("Thank you. Goodbye!");
      response.hangup();
  
      return res.type("text/xml").send(response.toString());
    } catch (error) {
      console.error("Incoming Call Error:", error);
      return apiResponse({
        res,
        statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
        message: "Failed to handle incoming call",
        status: false,
        data: null,
      });
    }
  };
  
  const makeCall = async (req, res) => {
    try {
      const call = await twilioClient.calls.create({
        url: "https://demo.twilio.com/docs/voice.xml",
        to: config.twilio.mynumber,
        from: config.twilio.from,
        record: true,
        recordingStatusCallback: `${config.serverBaseUrl}/twilio/recording-status`,
        recordingStatusCallbackEvent: ["completed"],
      });
  
      return apiResponse({
        res,
        statusCode: StatusCodes.OK,
        message: "Call initiated successfully.",
        status: true,
        data: { callSid: call.sid },
      });
    } catch (error) {
      console.error("Call Initiation Error:", error);
      return apiResponse({
        res,
        statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
        message: "Failed to initiate call",
        status: false,
        data: null,
      });
    }
  };
  
  const getAllRecordings = async (req, res) => {
    try {
      const recordings = await twilioClient.recordings.list({ limit: 20 });

      const authenticatedRecordings = recordings.map((recording) => ({
        sid: recording.sid,
        callSid: recording.callSid,
        duration: recording.duration,
        status: recording.status,
        dateCreated: recording.dateCreated,
        mediaUrl: `https://${config.twilio.accountSid}:${config.twilio.authToken}@api.twilio.com${recording.uri.replace('.json', '.mp3')}`, // Direct URL with auth
      }));
  
      return apiResponse({
        res,
        statusCode: StatusCodes.OK,
        message: "Recordings fetched successfully.",
        status: true,
        data: authenticatedRecordings,
      });
    } catch (error) {
      console.error("Get Recordings Error:", error);
      return apiResponse({
        res,
        statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
        message: "Failed to fetch recordings",
        status: false,
        data: null,
      });
    }
  };

export default { handleIncomingCall, makeCall , getAllRecordings};
