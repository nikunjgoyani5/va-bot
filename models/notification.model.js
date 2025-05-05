import mongoose from "mongoose";
import enumConfig from "../config/enum.config.js";

const notificationSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    notifications: [
      {
        title: { type: String },
        message: { type: String },
        type: {
          type: String,
          enum: Object.values(enumConfig.notificationTypeEnum),
        },
        priority: {
          type: String,
          enum: Object.values(enumConfig.notificationPriorityEnums),
          default: enumConfig.notificationPriorityEnums.MEDIUM,
        },
        actionUrl: { type: String },
        image: { type: String },
        isRead: { type: Boolean, default: false },
        deliveryMethods: {
          inApp: { type: Boolean, default: true },
          email: { type: Boolean, default: false },
          sms: { type: Boolean, default: false },
        },
        createdAt: { type: Date, default: Date.now },
      },
    ],
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

const Notification = mongoose.model("Notification", notificationSchema);
export default Notification;
