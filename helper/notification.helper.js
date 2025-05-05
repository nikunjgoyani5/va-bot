import config from "../config/config.js";
import enumConfig from "../config/enum.config.js";
import Notification from "../models/notification.model.js";
import OneSignal from "onesignal-node";
import admin from "../firebase/config.firebase.js";

const oneSignalClient = new OneSignal.Client(
  config.oneSignal.appId,
  config.oneSignal.apiKey
);

// -------- Send notification using one-signal ---------
export const sendNotification = async ({
  userId,
  title,
  message,
  type,
  priority = enumConfig.notificationPriorityEnums.MEDIUM,
  actionUrl,
  image = null,
  sendTime,
  deliveryMethods = { inApp: true, email: false, sms: false },
}) => {
  try {
    // If sendTime is not provided, set it to current UTC time
    const notificationTime = sendTime
      ? new Date(sendTime).toISOString()
      : new Date().toISOString();

    let userNotification = await Notification.findOne({ userId });

    if (!userNotification) {
      userNotification = new Notification({
        userId,
        notifications: [
          {
            title,
            message,
            type,
            priority,
            actionUrl,
            deliveryMethods,
            image,
            createdAt: new Date(),
          },
        ],
      });
      await userNotification.save();
    } else {
      await Notification.findOneAndUpdate(
        { userId },
        {
          $push: {
            notifications: {
              title,
              message,
              type,
              priority,
              actionUrl,
              deliveryMethods,
              image,
              createdAt: new Date(),
            },
          },
        },
        { new: true }
      );
    }

    // Prepare OneSignal notification payload
    const notificationData = {
      app_id: process.env.ONE_SIGNAL_APP_ID,
      included_segments: ["All"], // Send to all users
      // include_external_user_ids: [userId.toString()], // Send to single users
      contents: { en: message },
      headings: { en: title },
      big_picture: image || undefined,
      send_after: notificationTime,
    };

    let response = {};
    if (deliveryMethods.inApp) {
      response = await oneSignalClient.createNotification(notificationData);
      //   console.log({ onesignalNotificationId: response.body.id });
    }

    return { success: true, response };
  } catch (error) {
    console.error("Notification Error:", error);
    return { success: false, message: error.message };
  }
};

// -------- Send notification using firebase -----------
export const sendFCMNotification = async ({ token, title, message, image }) => {
  try {
    const messagePayload = {
      token,
      notification: { title, body: message, image },
      webpush: {
        headers: { Urgency: "high" },
        notification: { icon: image },
      },
    };

    const response = await admin.messaging().send(messagePayload);
    return { success: true, response };
  } catch (error) {
    console.error("FCM Notification Error:", error);
    return { success: false, message: error.message };
  }
};
