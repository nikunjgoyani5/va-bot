import { google } from "googleapis";
import dotenv from "dotenv";
import config from "../config/config.js";

dotenv.config();

const oauth2Client = new google.auth.OAuth2(
  config.google.clientId,
  config.google.clientSecret,
  config.google.redirectUrl
);

export default oauth2Client;
