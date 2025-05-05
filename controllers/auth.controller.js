import bcrypt from "bcrypt";
import { apiResponse } from "../helper/api-response.helper.js";
import enums from "../config/enum.config.js";
import config from "../config/config.js";
import helper from "../helper/common.helper.js";
import { StatusCodes } from "http-status-codes";
import userService from "../services/user.service.js";
import emailService from "../services/email.service.js";
import jwt from "jsonwebtoken";
import { google } from "googleapis";
import oauth2Client from "../config/googleclient.config.js";
import admin from "../firebase/config.firebase.js";
// import activityService from '../services/activity-track.service.js'
import axios from "axios";
import qs from "querystring";
import smsService from "../services/sms.service.js";
import calenderService from "../services/calender-event.service.js";

// For verify token
const verifyToken = async (req, res) => {
  try {
    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Token is verify successfully.",
      status: true,
      data: null,
    });
  } catch (error) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Internal server error",
      status: false,
      data: null,
    });
  }
};

// For google calender Use
const getGoogleAuthURL = (req, res) => {
  try {
    const authURL = oauth2Client.generateAuthUrl({
      access_type: "offline", // To get refresh_token
      prompt: "consent", // To force refresh_token every time
      scope: [
        "https://www.googleapis.com/auth/calendar",
        "https://www.googleapis.com/auth/userinfo.profile",
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/gmail.send", // To send email
        "https://www.googleapis.com/auth/gmail.readonly", // (Optional) To read emails
      ],
    });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Google Auth URL generated successfully.",
      status: true,
      data: { authURL },
    });
  } catch (error) {
    console.error("Google Auth URL Error:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to generate Google Auth URL.",
      status: false,
      data: null,
    });
  }
};

// For google calender Use
const googleAuthCallback = async (req, res) => {
  try {
    const { code } = req.query;
    const { tokens } = await oauth2Client.getToken(code);

    oauth2Client.setCredentials(tokens);

    // Get user info
    const oauth2 = google.oauth2({ version: "v2", auth: oauth2Client });
    const { data: userInfo } = await oauth2.userinfo.get();

    if (!userInfo.email) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "Email not found in Google Account",
        status: false,
        data: null,
      });
    }

    let user = await userService.findOne({ email: userInfo.email });

    if (!user) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "User not found. Please register first.",
        status: false,
        data: null,
      });
    }

    // Save tokens & expiry
    user.accessToken = tokens.access_token;
    user.refreshToken = tokens.refresh_token;
    user.expiresIn = tokens.expiry_date;
    user.googleEmail = userInfo.email;
    user.googleProfile = userInfo.picture;
    await user.save();

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Google Authentication Successful",
      status: true,
      data: {
        email: userInfo.email,
        name: userInfo.name,
        picture: userInfo.picture,
      },
    });
  } catch (error) {
    console.error("Google Auth Callback Error:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Google Authentication Failed",
      status: false,
      data: null,
    });
  }
};

// For email registration
const registerByEmail = async (req, res) => {
  try {
    const { email, password, firstName, lastName, mobileNumber } = req.body;

    let user = await userService.findOne({ email, isDeleted: false }, true);

    const { otp, otpExpiresAt } = helper.generateOTP();
    await emailService.sendOTPEmail({ email, otp, otpExpiresAt });

    if (user) {
      if (user.isVerified) {
        return apiResponse({
          res,
          status: false,
          message: "Email ID already in use",
          statusCode: StatusCodes.BAD_REQUEST,
          data: null,
        });
      } else {
        await userService.update(user._id, { otp, otpExpiresAt });
      }
    } else {
      const hashPassword = await bcrypt.hash(password, 10);
      const newUser = {
        email,
        password: hashPassword,
        provider: enums.authProviderEnum.EMAIL,
        otp,
        otpExpiresAt,
        firstName,
        lastName,
        mobileNumber,
        isVerified: false,
      };

      const userData = await userService.create(newUser);

      // await activityService.createActivity({
      //   userId: userData._id,
      //   email : userData.email,
      //   category: "auth",
      //   activityType: "Sign-up",
      //   description: "User Sign-up successfully",
      //   status: true,
      //   error: "",
      //   errorMessage: ""
      // });
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.CREATED,
      status: true,
      message: "Registration complete! Check your email for the verification OTP",
      data: null,
    });
  } catch (error) {
    // await activityService.createActivity({
    //   userId: null,
    //   email : req.body.email,
    //   category: "auth",
    //   activityType: "Sign-up",
    //   description: "User Sign-up failed!",
    //   status: false,
    //   error: error,
    //   errorMessage: error.message
    // });
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For verify email otp
const verifyEmailOtp = async (req, res) => {
  try {
    const { email, otp } = req.body;

    let user = await userService.findOne({ email, isDeleted: false });

    if (!user) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid email or user does not exist",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    if (user.otpExpiresAt && user.otpExpiresAt < new Date()) {
      return apiResponse({
        res,
        status: false,
        message: "OTP has expired",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    if (user.otp !== otp) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid OTP",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }
    
    if(user.backupEmail != null) {
      await userService.update(
        { email, isDeleted: false },
        { otp: null, otpExpiresAt: null, isVerified: true, otpVerified: true, email: user.backupEmail, backupEmail: null, recoveryMethods: {isEmail: false} }
      );
    } else {
      await userService.update(
        { email, isDeleted: false },
        { otp: null, otpExpiresAt: null, isVerified: true, otpVerified: true }
      );
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "OTP verified successfully!",
      data: null,
    });
  } catch (error) {
    console.error("Error in verifyOTP:", error);

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For verify mobile otp
const verifyMobileOtp = async (req, res) => {
  try {
    const { mobileNumber, otp } = req.body;
    let user = await userService.findOne({ mobileNumber, isDeleted: false });

    if (!user) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid mobileNumber or user does not exist",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    if (user.otpExpiresAt && user.otpExpiresAt < new Date()) {
      return apiResponse({
        res,
        status: false,
        message: "OTP has expired",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    if (user.otp !== otp) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid OTP",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }
    
    if(user.backupMobileNumber != null) {
      await userService.update(
        { mobileNumber, isDeleted: false },
        { otp: null, otpExpiresAt: null, isVerified: true, otpVerified: true, mobileNumber: user.backupMobileNumber, backupMobileNumber: null, countryCode: user.backupCountryCode, backupCountryCode: null, recoveryMethods: {isPhone: false} }
      );
    } else {
      await userService.update(
        { mobileNumber, isDeleted: false },
        { otp: null, otpExpiresAt: null, isVerified: true, otpVerified: true }
      );
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "OTP verified successfully!",
      data: null,
    });
  } catch (error) {
    console.error("Error in verifyOTP:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For resend back-up mobile otp
const resendMobileOtp = async (req, res) => {
  try {
    const { type, mobileNumber } = req.body;

    if (!["mobileNumber", "backupMobileNumber"].includes(type)) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid type. Use 'mobileNumber' or 'backupMobileNumber'.",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    let user = await userService.findOne({ [type]: mobileNumber, isDeleted: false });

    if (!user) {
      return apiResponse({
        res,
        status: false,
        message: `User with this ${type} does not exist.`,
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    const { otp, otpExpiresAt } = helper.generateOTP();

    // await smsService.sendOTPSMS({ mobileNumber, otp });

    await userService.update(
      { [type]: mobileNumber, isDeleted: false },
      { otp, otpExpiresAt }
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: `OTP has been resent successfully to ${type}!`,
      data: null,
    });
  } catch (error) {
    console.error("Error in resendEmailOtp:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For resend email otp
const resendEmailOtp = async (req, res) => {
  try {
    const { email, type } = req.body; // `type` can be 'email' or 'backupEmail'

    if (!type || (type !== "email" && type !== "backupEmail")) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid type. Use 'email' or 'backupEmail'",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    let user = await userService.findOne({ [type]: email, isDeleted: false });

    if (!user) {
      return apiResponse({
        res,
        status: false,
        message: "User does not exist",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    const { otp, otpExpiresAt } = helper.generateOTP();

    await emailService.sendOTPEmail({ email, otp, otpExpiresAt });

    await userService.update(
      { [type]: email, isDeleted: false },
      { otp, otpExpiresAt }
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: `OTP has been resent successfully to ${type}!`,
      data: null,
    });
  } catch (error) {
    console.error("Error in resendEmailOtp:", error);

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For email login
const loginByEmail = async (req, res) => {
  try {
    const { email, password } = req.body;

    let user = await userService.findOne({ email, isDeleted: false });

    if (!user) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid email or user does not exist",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    if (!user.isVerified) {
      return apiResponse({
        res,
        status: false,
        message: "Please first verify OTP to activate your account",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      return apiResponse({
        res,
        status: false,
        message: "Invalid password",
        statusCode: StatusCodes.UNAUTHORIZED,
        data: null,
      });
    }

    const token = jwt.sign(
      { userId: user._id, email: user.email },
      config.jwt.secretKey,
      {
        expiresIn: config.jwt.expiresIn || "7days",
      }
    );

    // await activityService.createActivity({
    //   userId: user._id,
    //   email: user.email,
    //   category: "auth",
    //   activityType: "Login",
    //   description: "User Login successfully",
    //   status: true,
    //   error: "",
    //   errorMessage : ""
    // });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "Login successful",
      data: {
        token,
        user,
      },
    });
  } catch (error) {
    console.error("error:", error);
    // console.log("error.msg" , error.message);

    // await activityService.createActivity({
    //   userId: null,
    //   email: req.body.email || "Unknown",
    //   userEmail: req.body.email || "Unknown",
    //   category: "auth",
    //   activityType: "Login",
    //   description: "Internal server error",
    //   status: false,
    //   error: error,
    //   errorMessage : error.message
    // });

    // console.error("Error in login:1111");

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

const forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    let user = await userService.findOne({ email, isDeleted: false });

    if (!user) {
      return apiResponse({
        res,
        status: false,
        message: "User not found",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    const { otp, otpExpiresAt } = helper.generateOTP();

    await emailService.sendOTPEmail({ email, otp });

    await userService.update({ email }, { otp, otpExpiresAt });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "OTP sent successfully!",
      data: null,
    });
  } catch (error) {
    console.error("Error in forgotOtp:", error);

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For reset password
const resetPassword = async (req, res) => {
  try {
    const { email, newPassword } = req.body;

    let user = await userService.findOne({ email, isDeleted: false });

    if (!user) {
      return apiResponse({
        res,
        status: false,
        message: "User not found",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    if (!user.otpVerified) {
      return apiResponse({
        res,
        status: false,
        message: "Please verify OTP before resetting password",
        statusCode: StatusCodes.BAD_REQUEST,
        data: null,
      });
    }

    const hashPassword = await bcrypt.hash(newPassword, 10);

    await userService.update(
      { email },
      { password: hashPassword, otpVerified: false }
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "Password reset successfully!",
      data: null,
    });
  } catch (error) {
    console.error("Error in resetPassword:", error);

    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For google login/registration
const loginByGoogle = async (req, res) => {
  try {
    const { token } = req.body;
    const decodedToken = await admin.auth().verifyIdToken(token);

    const { email, name, picture, uid: providerId } = decodedToken;

    let user = await userService.findOne({ email, isDeleted: false });

    if (!user) {
      const newUser = {
        firstName: name.split(" ")[0] || "",
        lastName: name.split(" ")[1] || "",
        email,
        profilePicture: picture ? [picture] : [],
        provider: enums.authProviderEnum.GOOGLE,
        providerId,
        isVerified: true,
      };

      user = await userService.create(newUser);
    } else {
      await userService.update(
        { email },
        {
          profilePicture: picture ? [picture] : user.profilePicture,
          provider: enums.authProviderEnum.GOOGLE,
          providerId,
        }
      );
    }

    const jwtToken = jwt.sign(
      { userId: user._id, email: user.email },
      config.jwt.secretKey,
      {
        expiresIn: config.jwt.expiresIn || "7days",
      }
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "Google login successful",
      data: {
        token: jwtToken,
        user,
      },
    });
  } catch (error) {
    console.error("Error during Google login:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal Server Error during Google login.",
      data: null,
    });
  }
};

// For apple login/registration
const loginByApple = async (req, res) => {
  try {
    const { token } = req.body;
    const decodedToken = await admin.auth().verifyIdToken(token);

    const { email, name, uid: providerId } = decodedToken;

    let user = await userService.findOne({ email, isDeleted: false });

    if (!user) {
      const generatedEmail = email || `${providerId}@appleid.com`;

      const newUser = {
        firstName: name?.split(" ")[0] || "Apple",
        lastName: name?.split(" ")[1] || "User",
        email: generatedEmail,
        provider: enums.authProviderEnum.APPLE,
        providerId,
        isVerified: true,
      };

      user = await userService.create(newUser);
    } else {
      await userService.update(
        { email },
        {
          provider: enums.authProviderEnum.APPLE,
          providerId,
        }
      );
    }

    const jwtToken = jwt.sign(
      { userId: user._id, email: user.email },
      config.jwt.secretKey,
      {
        expiresIn: config.jwt.expiresIn || "7days",
      }
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "Apple login successful",
      data: {
        token: jwtToken,
        user,
      },
    });
  } catch (error) {
    console.error("Error during Apple login:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal Server Error during Apple login.",
      data: null,
    });
  }
};

// For outlook auth url
const outlookAuthUrl = async (req, res) => {
  try {
    const userId = req.user.id;
    const user = await userService.findById(userId);
    if (user.outlookAccounts.length > 0) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "Outlook already connected",
      });
    }
    const authUrl = `https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=${config.outlook.clientId}&response_type=code&redirect_uri=${config.outlook.redirectUri}&scope=offline_access%20Calendars.ReadWrite&state=${userId}`;

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Outlook Auth URL generated successfully.",
      status: true,
      data: { authUrl },
    });
  } catch (error) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
      data: null,
    });
  }
};

// For outlook auth callback
const outlookAuthCallback = async (req, res) => {
  try {
    const { code } = req.query;
    const userId = req.query.state;

    const user = await userService.findById(userId);

    if (!user) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        status: false,
        message: "User not found",
        data: null,
      });
    }


    const tokenResponse = await calenderService.getMicrosoftAccessToken(code);
    user.outlookAccounts.push({
      accessToken: tokenResponse.access_token,
      refreshToken: tokenResponse.refresh_token,
      expiresIn: tokenResponse.expires_in,
    });
    await user.save();

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: "Outlook login successful",
      data: null,
    });
  } catch (error) {
    console.log(error.message, "error");
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Internal server error",
    });
  }
};

// For sync google calendar
const syncGoogleCalendar = async (req, res) => {
  try {
    const user = await userService.findById(req.user.id);

    if (!user) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        status: false,
        message: "User not found",
        data: null,
      });
    }

    const { accessToken, refreshToken } = user;
    if (!accessToken || !refreshToken) {
      return apiResponse({
        res,
        statusCode: StatusCodes.UNAUTHORIZED,
        status: false,
        message: "No tokens found for this user. Please reauthenticate.",
        data: null,
      });
    }

    oauth2Client.setCredentials({ access_token: accessToken, refresh_token: refreshToken });

    const accessTokenInfo = await oauth2Client.getAccessToken();
    if (accessTokenInfo?.token) {
      oauth2Client.setCredentials({ access_token: accessTokenInfo.token, refresh_token: refreshToken });
    } else {
      const { tokens: refreshedTokens } = await oauth2Client.refreshAccessToken();
      user.accessToken = refreshedTokens.access_token;
      await user.save();
      oauth2Client.setCredentials({
        access_token: refreshedTokens.access_token,
        refresh_token: refreshToken,
      });
    }

    const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
    const response = await calendar.events.list({
      calendarId: 'primary', 
      maxResults: 250, 
      singleEvents: true, 
      orderBy: 'startTime', 
    });

    const events = response.data.items;

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: 'Google Calendar synced successfully!',
      data: events,
    });
  } catch (error) {
    console.error(error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: 'Error syncing calendar with Google',
      data: null,
    });
  }
};

// For sync outlook calendar
const syncOutlookCalendar = async (req , res) => {
  try {
    // console.log(req.user);
    
    const response = await axios.get(`https://graph.microsoft.com/v1.0/users/${req.user.email}/calendars/${req.user.integrations.outlookCalendar.calendarId}/events`, {
      headers: {
        Authorization: `Bearer ${req.user.outlookAccounts[0].accessToken}`},
    });

    const formattedAppointments = response.data.value.map((event) => ({
      client: {
        name: event.attendees?.[0]?.emailAddress?.name || 'Unknown',
        email: event.attendees?.[0]?.emailAddress?.address || '',
        phone: '',
      },
      appointmentType: event.subject || 'Meeting',
      startTime: event.start.dateTime,
      endTime: event.end.dateTime,
      propertyAddress: event.location?.displayName || 'Online',
      notes: event.bodyPreview || '',
      image: '',
      googleCalendarId: '',
      outlookCalendarId: event.id,
      status: 'PENDING',
      rescheduledFrom: null,
      isMissed: false,
    }));

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      status: true,
      message: 'Outlook Calendar synced successfully!',
      data: formattedAppointments,
    })
  } catch (error) {
    console.error('Error fetching events:', error);
    throw error;
  }
}

export default {
  verifyToken,
  registerByEmail,
  loginByEmail,
  forgotPassword,
  verifyEmailOtp,
  verifyMobileOtp,
  resendEmailOtp,
  resendMobileOtp,
  verifyToken,
  resetPassword,
  loginByGoogle,
  loginByApple,
  googleAuthCallback,
  getGoogleAuthURL,
  outlookAuthUrl,
  outlookAuthCallback,
  syncGoogleCalendar,
  syncOutlookCalendar
};
