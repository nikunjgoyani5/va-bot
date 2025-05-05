import mongoose from "mongoose";
import enums from "../config/enum.config.js";
import passportLocalMongoose from "passport-local-mongoose";
import speakeasy from "speakeasy";
import QRCode from "qrcode";
import config from "../config/config.js";

const multiFactorAuthSchema = new mongoose.Schema({
  isEnabled: { type: Boolean, default: false },
  verificationMethod: {
    type: String,
    enum: Object.values(enums.verificationMethodEnum),
    default: null,
  },
  otp: {
    code: { type: String, default: null }, // Stores OTP for SMS & Email
    expiresAt: { type: Date, default: null }, // Expiration time for OTP
  },
  secretKey: { type: String, default: null }, // For Authenticator App
  twoFactorQr: { type: String, default: null }, // QR Code for Authenticator App
  recoveryCodes: [{ type: String }], // Backup codes for account recovery
  mfaStatus: {
    type: String,
    enum: Object.values(enums.mfaStatusEnum),
    default: enums.mfaStatusEnum.DISABLED,
  },
});

const integrationSchema = new mongoose.Schema({
  googleCalendar: {
    enabled: { type: Boolean, default: false },
    calendarId: { type: String, default: null },
    lastSync: { type: Date, default: null },
    syncFrequency: {
      type: String,
      enum: Object.values(enums.syncFrequencyEnum),
    },
  },
  twilio: {
    enabled: { type: Boolean, default: false },
    accountSid: { type: String, default: null },
    authToken: { type: String, default: null }, // Twilio requires Auth Token
    fromNumber: { type: String, default: null },
    lastSync: { type: Date, default: null },
    syncFrequency: {
      type: String,
      enum: Object.values(enums.syncFrequencyEnum),
    },
  },
  slack: {
    enabled: { type: Boolean, default: false },
    webhookUrl: { type: String, default: null },
    lastSync: { type: Date, default: null },
    syncFrequency: {
      type: String,
      enum: Object.values(enums.syncFrequencyEnum),
    },
  },
  crmIntegration: {
    enabled: { type: Boolean, default: false },
  },
  gmail: {
    enabled: { type: Boolean, default: false },
  },
  outlookCalendar: {
    enabled: { type: Boolean, default: false },
    calendarId: { type: String, default: null },
  },
  icloudCalendar: {
    enabled: { type: Boolean, default: false },
    calendarId: { type: String, default: null },
  },
  lofty: {
    enabled: { type: Boolean, default: false },
  },
  salesforce: {
    enabled: { type: Boolean, default: false },
  },
  kvCore: {
    enabled: { type: Boolean, default: false },
  },
  followupBoss: {
    enabled: { type: Boolean, default: false },
  },
});

const transactionPreferencesSchema = new mongoose.Schema({
  transactionRange: {
    type: Object,
    enum: Object.values(enums.transactionRangeEnum),
  },
});

const leadCommunicationSchema = new mongoose.Schema({
  leadFollowUpTime: {
    type: String,
    enum: Object.values(enums.leadFollowUpEnum),
  },
  bookingMethod: {
    type: String,
    enum: Object.values(enums.bookingMethodEnum),
  },
  confirmationAutomation: {
    type: Boolean,
    default: false,
  },
  botCallPreference: {
    type: String,
    enum: Object.values(enums.botCallPreferenceEnum),
  },
});

const crmIntegrationSchema = new mongoose.Schema({
  syncWithCRM: { type: Boolean, default: false },
  leadTrackingMethod: {
    type: String,
    enum: Object.values(enums.leadTrackingMethodEnum),
  },
});

const businessGoalsSchema = new mongoose.Schema({
  businessGoal: {
    closeMoreDeals: { type: Boolean, default: false },
    saveHoursPerWeek: { type: Boolean, default: false },
    increaseLeadConversion: { type: Boolean, default: false },
    automateOfferWriting: { type: Boolean, default: false },
  },
  vaBotCapabilities: {
    scheduleShowings: { type: Boolean, default: false },
    handlePostOfferManagement: { type: Boolean, default: false },
    followUpWithLeads: { type: Boolean, default: false },
    writeAndSubmitOffers: { type: Boolean, default: false },
  },
});

const workflowSchema = new mongoose.Schema({
  leadAutoReply: { type: Boolean, default: false },
  leadFollowUpReminders: {
    type: String,
    enum: Object.values(enums.leadFollowUpTimeEnum),
  },
  workflowAutomations: { type: Boolean, default: false },
  notificationPreferences: {
    // Prefered Notification Method
    preferedNotificationMethod: {
      type: String,
      enum: Object.values(enums.preferedNotificationMethods),
    },
    newOffers: { type: Boolean, default: false },
    callSummary: { type: Boolean, default: false },
    leadAutoReply: { type: Boolean, default: false },
    scheduleChanges: { type: Boolean, default: false },
    leadFollowUps: { type: Boolean, default: false },
    pushNotifications: { type: Boolean, default: true },
    doNotDisturb: {
      enabled: { type: Boolean, default: false },
      startTime: { type: String },
      endTime: { type: String },
    },
    newAppointmentScheduled: { type: Boolean, default: false },
    offerUpdateReceived: { type: Boolean, default: false },
    feedbackRequestSent: { type: Boolean, default: false },
  },
});

const linkedPreferencesSchema = new mongoose.Schema({
  linkedin: { type: String, default: null },
  facebook: { type: String, default: null },
  instagram: { type: String, default: null },
  zillow: { type: String, default: null },
});

const schema = new mongoose.Schema(
  {
    email: {
      type: String,
      required: true,
    },
    backupEmail: {
      type: String,
      default: null,
    },
    backupMobileNumber: {
      type: Number,
      default: null,
    },
    backupCountryCode: { type: String, default: null },
    recoveryMethods: {
      isEmail: { type: Boolean, default: false },
      isPhone: { type: Boolean, default: false },
    },
    password: {
      type: String,
      default: null,
    },
    mobileNumber: {
      type: Number,
      required: true,
    },
    firstName: {
      type: String,
      required: true,
    },
    lastName: {
      type: String,
      required: true,
    },
    fullName: {
      type: String,
      default: null,
    },
    profileImage: {
      type: String,
      default: null,
    },
    providerId: {
      type: String,
      default: null,
    },
    provider: {
      type: String,
      enum: Object.values(enums.authProviderEnum),
      required: true,
    },
    role: {
      type: String,
      enum: Object.values(enums.userRoleEnum),
      default: null,
    },
    otp: {
      type: Number,
      default: null,
    },
    otpExpiresAt: {
      type: Date,
      default: null,
    },
    isDeleted: {
      type: Boolean,
      default: false,
      index: true,
    },
    isVerified: {
      type: Boolean,
      default: false,
      index: true,
    },
    otpVerified: {
      type: Boolean,
      default: false,
    },
    twilioNumber: {
      type: Number,
      default: null,
    },
    accessToken: {
      type: String,
      default: null,
    },
    refreshToken: {
      type: String,
      default: null,
    },
    expiresIn: {
      type: String,
      default: null,
    },
    secretKey: { type: String },
    isTwoFactorEnabled: { type: Boolean, default: false },
    twoFactorQr: { type: String, trim: true },
    recoveryCode: [{ type: Number }],
    // multiFactorAuth: multiFactorAuthSchema,
    onboardingUrl: { type: String, default: null },
    integrations: integrationSchema,
    transactionPreferences: transactionPreferencesSchema,
    leadCommunication: leadCommunicationSchema,
    crmIntegration: crmIntegrationSchema,
    businessGoals: businessGoalsSchema,
    workflow: workflowSchema,
    isCompleted: { type: Boolean, default: false },
    fcmToken: { type: String, default: null },
    salesforceAccounts: [
      {
        accessToken: { type: String, default: null },
        refreshToken: { type: String, default: null },
        instanceUrl: { type: String, default: null },
        codeVerifier: { type: String, default: null },
        expiresIn: { type: Number, default: null },
        createdAt: { type: Date, default: null },
      },
    ],
    followUpBossAccounts: [
      {
        accessToken: { type: String, default: null },
        refreshToken: { type: String, default: null },
        tokenType: { type: String, default: "Bearer" },
        expiresIn: { type: Number, default: null },
        scope: { type: String, default: null },
        createdAt: { type: Date, default: Date.now },
        userId: { type: String, default: null },
        connectedEmail: { type: String, default: null },
      },
    ],
    brokerageName: { type: String, default: null },
    licenseNumber: { type: String, default: null },
    speAreas: { type: String, default: null },
    experience: { type: Number },
    linkedPreferences: linkedPreferencesSchema,
    countryCode: { type: String },
    outlookAccounts: [
      {
        accessToken: { type: String, default: null },
        refreshToken: { type: String, default: null },
        expiresIn: { type: Number, default: null },
      },
    ],
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

schema.index({ provider: 1, providerId: 1 });

schema.plugin(passportLocalMongoose);

// Method to enable 2FA and generate QR code
schema.methods.enableTwoFactorAuthentication = async function () {
  if (!this.secretKey) {
    const secret = speakeasy.generateSecret({
      length: 20,
      name: config.appName,
    });
    this.secretKey = secret.base32;

    await this.save();

    // Generate QR code for user to scan with Google Authenticator
    const qrCode = await QRCode.toDataURL(secret.otpauth_url);
    return { secret: secret.base32, qrCode };
  }

  return null; // 2FA is already enabled
};

const UserModel = mongoose.model("User", schema);
export default UserModel;
