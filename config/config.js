import Joi from "joi";
import dotenv from "dotenv";
import enums from "./enum.config.js";
import { parseJoiError } from "../helper/api-response.helper.js";

const nodeEnv = enums.nodeEnvEnums.PRODUCTION;

dotenv.config({
  path: nodeEnv === enums.nodeEnvEnums.DEVELOPMENT ? ".env.dev" : ".env",
});

console.log(
  `Loaded env file: ${
    nodeEnv === enums.nodeEnvEnums.DEVELOPMENT ? ".env.dev" : ".env"
  }`
);

const envVarsSchema = Joi.object({
  PORT: Joi.number().required(),
  MONGODB_URL: Joi.string().trim().required(),
  CLIENT_URL: Joi.string().trim().required(),
  BASE_URL: Joi.string().trim().required(),
  FRONTEND_URL: Joi.string().trim().optional(),
  SERVER_URL: Joi.string().trim().required(),
  JWT_SECRET_KEY: Joi.string().required(),
  JWT_TOKEN_EXPIRES_IN: Joi.string().optional(),
  OTP_EXPIRY_DURATION_SECONDS: Joi.number().optional(),
  APP_NAME: Joi.string().required(),

  SMTP_HOST: Joi.string().required(),
  SMTP_PORT: Joi.number().required(),
  SMTP_USERNAME: Joi.string().required(),
  SMTP_PASSWORD: Joi.string().required(),
  EMAIL_FROM: Joi.string().required(),

  GOOGLE_CLIENT_ID: Joi.string().required(),
  GOOGLE_CLIENT_SECRET: Joi.string().required(),
  GOOGLE_REDIRECT_URL: Joi.string().required(),

  DIGITAL_OCEAN_DIRNAME: Joi.string().required(),
  DIGITAL_OCEAN_SPACES_ACCESS_KEY: Joi.string().required(),
  DIGITAL_OCEAN_SPACES_SECRET_KEY: Joi.string().required(),
  DIGITAL_OCEAN_SPACES_REGION: Joi.string().required(),
  DIGITAL_OCEAN_SPACES_BASE_URL: Joi.string().required(),
  DIGITAL_OCEAN_BUCKET_NAME: Joi.string().required(),
  DIGITAL_OCEAN_ENDPOINT: Joi.string().required(),

  TWILIO_ACCOUNT_SID: Joi.string().required(),
  TWILIO_AUTH_TOKEN: Joi.string().required(),

  FIREBASE_TYPE: Joi.string().required(),
  FIREBASE_PROJECT_ID: Joi.string().required(),
  FIREBASE_PRIVATE_KEY_ID: Joi.string().required(),
  FIREBASE_PRIVATE_KEY: Joi.string().required(),
  FIREBASE_CLIENT_EMAIL: Joi.string().required(),
  FIREBASE_CLIENT_ID: Joi.string().required(),
  FIREBASE_AUTH_URI: Joi.string().required(),
  FIREBASE_TOKEN_URI: Joi.string().required(),
  FIREBASE_AUTH_PROVIDER_X509_CERT_URL: Joi.string().required(),
  FIREBASE_CLIENT_X509_CERT_URL: Joi.string().required(),

  ONE_SIGNAL_APP_ID: Joi.string().optional(),
  ONE_SIGNAL_ANDROID_CHANNEL_ID: Joi.string().optional(),
  ONE_SIGNAL_API_KEY: Joi.string().optional(),

  SUPPORT_EMAIL: Joi.string().optional(),
  SUPPORT_PASSWORD: Joi.string().optional(),

  OUTLOOK_CLIENT_ID: Joi.string().required(),
  OUTLOOK_CLIENT_SECRET: Joi.string().required(),
  OUTLOOK_REDIRECT_URI: Joi.string().required(),
  OUTLOOK_TOKEN_URL: Joi.string().required(),
  OUTLOOK_GRAPH_URL: Joi.string().required(),
})
  .unknown()
  .prefs({ errors: { label: "key" } });

const { value: envVars, error } = envVarsSchema.validate(process.env, {
  abortEarly: false,
});

if (error) {
  const parsedError = parseJoiError(error);
  console.log("Config Error: ", parsedError);
  throw new Error("Invalid environment variables");
}

export default {
  port: envVars.PORT,
  appName: envVars.APP_NAME,
  nodeEnv,
  mongodb: {
    url: envVars.MONGODB_URL,
    options: {},
  },
  base_url: envVars.BASE_URL,
  frontendUrl: envVars.FRONTEND_URL,
  server_url: envVars.SERVER_URL,
  client_url: envVars.CLIENT_URL,
  jwt: {
    secretKey: envVars.JWT_SECRET_KEY,
    expiresIn: envVars.JWT_TOKEN_EXPIRES_IN || "7d",
  },
  otpExpiryDurationSeconds: envVars.OTP_EXPIRY_DURATION_SECONDS || 300,
  google: {
    clientId: envVars.GOOGLE_CLIENT_ID,
    clientSecret: envVars.GOOGLE_CLIENT_SECRET,
    redirectUrl: envVars.GOOGLE_REDIRECT_URL,
  },
  cloud: {
    digitalocean: {
      rootDirname: envVars.DIGITAL_OCEAN_DIRNAME,
      region: envVars.DIGITAL_OCEAN_SPACES_REGION,
      baseUrl: envVars.DIGITAL_OCEAN_SPACES_BASE_URL,
      bucketName: envVars.DIGITAL_OCEAN_BUCKET_NAME,
      endpoint: envVars.DIGITAL_OCEAN_ENDPOINT,
      credentials: {
        accessKeyId: envVars.DIGITAL_OCEAN_SPACES_ACCESS_KEY,
        secretAccessKey: envVars.DIGITAL_OCEAN_SPACES_SECRET_KEY,
      },
    },
  },
  nodemailer: {
    host: envVars.SMTP_HOST,
    port: envVars.SMTP_PORT,
    auth: {
      user: envVars.SMTP_USERNAME,
      pass: envVars.SMTP_PASSWORD,
    },
    supportEmail: envVars.SUPPORT_EMAIL,
    supportPassword: envVars.SUPPORT_PASSWORD,
  },
  email: {
    from: envVars.EMAIL_FROM,
  },
  twilio: {
    accountSid: envVars.TWILIO_ACCOUNT_SID,
    authToken: envVars.TWILIO_AUTH_TOKEN,
    apiKey: process.env.TWILIO_API_KEY,
    apiSecret: process.env.TWILIO_API_SECRET,
    from: process.env.TWILIO_FROM_NUMBER,
    mynumber: process.env.MY_VERIFIED_NUMBER,
  },
  firebase: {
    type: envVars.FIREBASE_TYPE,
    projectId: envVars.FIREBASE_PROJECT_ID,
    privateKeyId: envVars.FIREBASE_PRIVATE_KEY_ID,
    privateKey: envVars.FIREBASE_PRIVATE_KEY,
    clientEmail: envVars.FIREBASE_CLIENT_EMAIL,
    clientId: envVars.FIREBASE_CLIENT_ID,
    authUri: envVars.FIREBASE_AUTH_URI,
    tokenUri: envVars.FIREBASE_TOKEN_URI,
    authProviderX509CertUrl: envVars.FIREBASE_AUTH_PROVIDER_X509_CERT_URL,
    clientX509CertUrl: envVars.FIREBASE_CLIENT_X509_CERT_URL,
  },
  oneSignal: {
    appId: envVars.ONE_SIGNAL_APP_ID,
    androidChannelId: envVars.ONE_SIGNAL_ANDROID_CHANNEL_ID,
    apiKey: envVars.ONE_SIGNAL_API_KEY,
  },
  bucketStorageFolders: {
    SUPPORT_REQUEST: envVars.SUPPORT_REQUEST_BUCKET_STORAGE,
    APPOINTMENT: envVars.APPOINTMENT_BUCKET_STORAGE,
  },
  serverBaseUrl: envVars.SERVER_BASE_URL,
  salesForceCRM: {
    authUrl: envVars.SF_AUTH_URL,
    tokenUrl: envVars.SF_TOKEN_URL,

    clientId: envVars.SF_CLIENT_ID,
    clientSecret: envVars.SF_CLIENT_SECRET,
    redirectUri: envVars.SF_REDIRECT_URI,
  },
  followUpBossCRM: {
    authUrl: envVars.FB_AUTH_URL,
    tokenUrl: envVars.FB_TOKEN_URL,

    clientId: envVars.FB_CLIENT_ID,
    clientSecret: envVars.FB_CLIENT_SECRET,
    redirectUri: envVars.FB_REDIRECT_URI,
  },
  followUpBoss: {
    clientId: process.env.FUB_CLIENT_ID,
    clientSecret: process.env.FUB_CLIENT_SECRET,
    authUrl: process.env.FUB_AUTH_URL,
    tokenUrl: process.env.FUB_TOKEN_URL,
    redirectUri: process.env.FUB_REDIRECT_URI,
  },
  outlook: {
    clientId: envVars.OUTLOOK_CLIENT_ID,
    clientSecret: envVars.OUTLOOK_CLIENT_SECRET,
    redirectUri: envVars.OUTLOOK_REDIRECT_URI,
    tokenUrl: envVars.OUTLOOK_TOKEN_URL,
    graphUrl: envVars.OUTLOOK_GRAPH_URL,
  },
  
};
