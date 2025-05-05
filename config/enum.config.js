const nodeEnvEnums = {
  PRODUCTION: "production",
  DEVELOPMENT: "development",
};

const authProviderEnum = {
  GOOGLE: "google",
  APPLE: "apple",
  EMAIL: "email",
  MOBILE: "mobile",
};

const bucketFolderEnum = {
  OFFER: "offer",
};

const userRoleEnum = {
  USER: "user",
  ADMIN: "admin",
  OWNER: "owner",
};

const statusSupportEnum = {
  OPEN: "open",
  CLOSE: "close",
};

const socketEventEnums = {
  SEND_MESSAGE: "send_message",
};

const appointmentStatusEnum = {
  PENDING: "pending",
  CANCELLED: "cancelled",
  MISSED: "missed",
  RESCHEDULED: "rescheduled",
};

const notificationTypeEnum = {
  APPOINTMENT: "appointment",
  OFFER: "offer",
  FEEDBACK: "feedback",
};

const notificationPriorityEnums = {
  HIGH: "high",
  MEDIUM: "medium",
  LOW: "low",
};

const preferedNotificationMethods = {
  InAPP: "in-app",
  EMAIL: "email",
  SMS: "sms",
}

const verificationMethodEnum = {
  SMS: "sms",
  EMAIL: "email",
  AUTHENTICATOR_APP: "authenticator_app",
};

const mfaStatusEnum = {
  PENDING: "pending",
  VERIFIED: "verified",
  DISABLED: "disabled",
};

const transactionRangeEnum = {
  ZERO_TO_TWO: { min: 0, max: 2 },
  THREE_TO_FIVE: { min: 3, max: 5 },
  SIX_TO_TEN: { min: 6, max: 10 },
  ELEVEN_TO_TWENTY: { min: 11, max: 20 },
  TWENTY_ONE_TO_FIFTY: { min: 21, max: 50 },
  FIFTY_PLUS: { min: 51, max: Infinity },
};

const leadFollowUpEnum = {
  IMMEDIATELY: "Immediately",
  WITHIN_24_HOURS: "Within 24 hours",
  WITHIN_3_DAYS: "Within 3 days",
  WITHIN_A_WEEK: "Within a week",
};

const bookingMethodEnum = {
  MANUAL: "Manual booking",
  AUTOMATED: "Automated booking",
};

const botCallPreferenceEnum = {
  IMMEDIATE_CALLS: "Yes, call all leads immediately",
  WARM_LEADS_ONLY: "Yes, but only warm leads",
  MANUAL_CALLS: "No, I will call leads myself",
};

const leadTrackingMethodEnum = {
  CRM: "CRM",
  SPREADSHEET: "Spreadsheet",
  NOTEBOOK: "Notebook",
};

const businessGoalEnum = {
  CLOSE_MORE_DEALS: "Close More Deals",
  SAVE_HOURS: "Save 10+ Hours Per Week",
  INCREASE_LEAD_CONVERSION: "Increase Lead Conversion",
  AUTOMATE_OFFER_WRITING: "Automate Offer Writing",
};

const VABotCapabilitiesEnum = {
  SCHEDULE_SHOWINGS: "Schedule showings & confirm appointments",
  HANDLE_TRANSACTIONS: "Handle post-offer transaction management",
  FOLLOW_UP_LEADS: "Follow up with leads",
  WRITE_SUBMIT_OFFERS: "Write & submit offers",
};

const leadFollowUpTimeEnum = {
  ONE_HOUR: "1 Hour",
  TWO_HOURS: "2 Hours",
  THREE_HOURS: "3 Hours",
  FOUR_HOURS: "4 Hours",
};

const OfferManagmentEnum = {
  WAITING_FOR_SIGNATURE: "Waiting for Signature",
  SIGNED_BY_SELLER: "Signed by Seller",
  SIGNED_BY_BUYER: "Signed by Buyer",
  UNDER_REVIEW: "Under Review",
  SENT_TO_LISTING_AGENT: "Sent to Listing Agent",
};

const appointmentTypeEnum = {
  MEETING: "meeting",
  PROPERTY_SHOWING: "property showing",
};

const calenderTypeEnum = {
  GOOGLE: "google",
  OUTLOOK: "outlook",
};

const acvityCategoryTypeEnum = {
  AUTH: "auth",
  APPOINTMENT: "appointment",
}

const activityTypeEnum = {
  SIGNUP: "signup",
  LOGIN: "login",
  LOGOUT: "logout",
  APPOINTMENT_CREATE: "Create Appointment",
  APPOINTMENT_CANCEL: "Cancel Appointment",
  APPOINTMENT_RESCHEDULE: "Reschedule Appointment",
  APPOINTMENT_MISSED: "Appointment Missed",
}

const syncFrequencyEnum = {
  FIVE_MIN: "5m",
  TEN_MIN: "10m",
  FIFTEEN_MIN: "15m",
  THIRTY_MIN: "30m",
  HOUR: "1h",
  DAY: "1d",
};

export default {
  nodeEnvEnums,
  authProviderEnum,
  userRoleEnum,
  socketEventEnums,
  statusSupportEnum,
  appointmentStatusEnum,
  notificationTypeEnum,
  verificationMethodEnum,
  mfaStatusEnum,
  transactionRangeEnum,
  leadFollowUpEnum,
  bookingMethodEnum,
  botCallPreferenceEnum,
  leadTrackingMethodEnum,
  businessGoalEnum,
  VABotCapabilitiesEnum,
  leadFollowUpTimeEnum,
  notificationPriorityEnums,
  preferedNotificationMethods,
  OfferManagmentEnum,
  appointmentTypeEnum,
  calenderTypeEnum,
  acvityCategoryTypeEnum,
  activityTypeEnum,
  syncFrequencyEnum,
  bucketFolderEnum
};
