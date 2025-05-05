import Joi from "joi";
import enumConfig from "../config/enum.config.js";

const updateUserProfile = {
  body: Joi.object().keys({
    firstName: Joi.string().min(1).max(50),
    lastName: Joi.string().min(1).max(50),
    fullName: Joi.string().min(1).max(100),
    email: Joi.string().email(),
    mobileNumber: Joi.string(),
    countryCode: Joi.string(),
    profileImage: Joi.string().allow(null, ""),
    role: Joi.string().valid(...Object.values(enumConfig.userRoleEnum)),
    twilioNumber: Joi.string()
      .pattern(/^[0-9]{10,15}$/)
      .allow(null, ""),
    accessToken: Joi.string().allow(null, ""),
    refreshToken: Joi.string().allow(null, ""),
    integrations: Joi.object({
      googleCalendar: Joi.object({
        enabled: Joi.boolean(),
        calendarId: Joi.string().allow(null, ""),
        lastSync: Joi.date(),
        syncFrequency: Joi.string().valid(...Object.values(enumConfig.syncFrequencyEnum)),
      }),
      twilio: Joi.object({
        enabled: Joi.boolean(),
        accountSid: Joi.string().allow(null, ""),
        fromNumber: Joi.string().allow(null, ""),
        authToken: Joi.string().allow(null, ""),
        lastSync: Joi.date(),
        syncFrequency: Joi.string().valid(...Object.values(enumConfig.syncFrequencyEnum)),
      }),
      slack: Joi.object({
        enabled: Joi.boolean(),
        webhookUrl: Joi.string().allow(null, ""),
        lastSync: Joi.date(),
        syncFrequency: Joi.string().valid(...Object.values(enumConfig.syncFrequencyEnum)),
      }),
      crmIntegration: Joi.object({
        enabled: Joi.boolean(),
      }),
      gmail: Joi.object({
        enabled: Joi.boolean(),
      }),
      outlookCalendar: Joi.object({
        enabled: Joi.boolean(),
        calendarId: Joi.string().allow(null, ""),
      }),
      icloudCalendar: Joi.object({
        enabled: Joi.boolean(),
        calendarId: Joi.string().allow(null, ""),
      }),
      lofty: Joi.object({
        enabled: Joi.boolean(),
      }),
      salesforce: Joi.object({
        enabled: Joi.boolean(),
      }),
      kvCore: Joi.object({
        enabled: Joi.boolean(),
      }),
      followupBoss: Joi.object({
        enabled: Joi.boolean(),
      }),
    }),
    transactionPreferences: Joi.object({
      transactionRange: Joi.object()
        .keys({
          min: Joi.number().required(),
          max: Joi.number().required(),
        })
    }),    
    leadCommunication: Joi.object({
      leadFollowUpTime: Joi.string().valid(
        ...Object.values(enumConfig.leadFollowUpEnum)
      ),
      bookingMethod: Joi.string().valid(
        ...Object.values(enumConfig.bookingMethodEnum)
      ),
      confirmationAutomation: Joi.boolean().default(false),
      botCallPreference: Joi.string().valid(
        ...Object.values(enumConfig.botCallPreferenceEnum)
      ),
    }),
    crmIntegration: Joi.object({
      syncWithCRM: Joi.boolean(),
      leadTrackingMethod: Joi.string().valid(
        ...Object.values(enumConfig.leadTrackingMethodEnum)
      ),
    }),
    businessGoals: Joi.object({
      businessGoal: Joi.object({
        closeMoreDeals: Joi.boolean().default(false),
        saveHoursPerWeek: Joi.boolean().default(false),
        increaseLeadConversion: Joi.boolean().default(false),
        automateOfferWriting: Joi.boolean().default(false),
      }),
      vaBotCapabilities: Joi.object({
        scheduleShowings: Joi.boolean().default(false),
        handlePostOfferManagement: Joi.boolean().default(false),
        followUpWithLeads: Joi.boolean().default(false),
        writeAndSubmitOffers: Joi.boolean().default(false),
      })
    }),
    workflow: Joi.object({
      leadAutoReply: Joi.boolean(),
      leadFollowUpReminders: Joi.string().valid(
        ...Object.values(enumConfig.leadFollowUpTimeEnum)
      ),
      workflowAutomations: Joi.boolean(),
      notificationPreferences: Joi.object({
        preferedNotificationMethod: Joi.string().valid(
          ...Object.values(enumConfig.preferedNotificationMethods)
        ),
        newOffers: Joi.boolean(),
        callSummary: Joi.boolean(),
        leadAutoReply: Joi.boolean(),
        scheduleChanges: Joi.boolean(),
        leadFollowUps: Joi.boolean(),
        pushNotifications: Joi.boolean(),
        doNotDisturb: Joi.object({
          enabled: Joi.boolean(),
          startTime: Joi.string(),
          endTime: Joi.string(),
        }),
        newAppointmentScheduled: Joi.boolean(),
        offerUpdateReceived: Joi.boolean(),
        feedbackRequestSent : Joi.boolean()
      }),
    }),
    isCompleted: Joi.boolean(),
    brokerageName: Joi.string(),
    licenseNumber: Joi.string(),
    speAreas: Joi.string(),
    experience: Joi.number(),
    linkedPreferences: Joi.object().keys({
      linkedin: Joi.string(),
      facebook: Joi.string(),
      instagram: Joi.string(),
      zillow: Joi.string(),
    }),
  }),
};

const deleteUserAccountValidation = {
  body: Joi.object().keys({
    isPermanentlyDelete: Joi.boolean().required(),
  }),
};

const updateUserFCMToken = {
  body: Joi.object().keys({
    fcmToken: Joi.string().required(),
  }),
};

const linkedPreferencesValidation = {
  body: Joi.object().keys({
    linkedPreferences: Joi.object().keys({
      linkedin: Joi.string(),
      facebook: Joi.string(),
      instagram: Joi.string(),
      zillow: Joi.string(),
    }),
  }),
};

const sendMail = {
  body: Joi.object().keys({
    to: Joi.string().email().required(),
    subject: Joi.string().required(),
    body: Joi.string().required(),
  }),
};

const changePassword = {
  body: Joi.object().keys({
    oldPassword: Joi.string().required(),
    newPassword: Joi.string().required(),
    conformNewPassword: Joi.string().valid(Joi.ref("newPassword")).required(),
  }),
};

const recoveryEmail = {
  body: Joi.object().keys({
    backupEmail: Joi.string().email().required(),
  }),
}

const recoveryMobileNumber = {
  body: Joi.object().keys({
    backupMobileNumber: Joi.number().strict().required(),
    backupCountryCode: Joi.string().required(),
  }),
}

export default {
  updateUserProfile,
  deleteUserAccountValidation,
  updateUserFCMToken,
  linkedPreferencesValidation,
  sendMail,
  changePassword,
  recoveryEmail,
  recoveryMobileNumber
};
