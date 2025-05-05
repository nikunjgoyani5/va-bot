import Joi from "joi";

const verifyToken = {
  body: Joi.object().keys({
    token: Joi.string().required(),
  }),
};

const registerByEmail = {
  body: Joi.object().keys({
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
    password: Joi.string().required().messages({
      "string.base": "Password must be a string",
      "any.required": "Password is required",
      "string.empty": "Password cannot be empty",
    }),
    firstName: Joi.string().required().messages({
      "string.base": "firstName must be a string",
      "any.required": "firstName is required",
      "string.empty": "firstName cannot be empty",
    }),
    lastName: Joi.string().required().messages({
      "string.base": "lastName must be a string",
      "any.required": "lastName is required",
      "string.empty": "lastName cannot be empty",
    }),
    mobileNumber: Joi.number().strict().required().messages({
      "number.base": "mobileNumber must be a number",
      "any.required": "mobileNumber is required",
      "number.empty": "mobileNumber cannot be empty",
    }),
  }),
};

const verifyEmailOtp = {
  body: Joi.object().keys({
    otp: Joi.number()
      .strict()
      .integer()
      .min(100000)
      .max(999999)
      .required()
      .messages({
        "number.base": "OTP must be a number",
        "number.min": "OTP must be a 6-digit number",
        "number.max": "OTP must be a 6-digit number",
        "any.required": "OTP is required",
      }),
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
  }),
};

const resendEmailOtp = {
  body: Joi.object().keys({
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
    type: Joi.string().required().messages({
      "string.base": "Type must be a string",
      "any.required": "Type is required",
      "string.empty": "Type cannot be empty",
    }),
  }),
};

const loginByEmail = {
  body: Joi.object().keys({
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
    password: Joi.string().required().messages({
      "string.base": "Password must be a string",
      "any.required": "Password is required",
      "string.empty": "Password cannot be empty",
    }),
  }),
};

const forgotPassword = {
  body: Joi.object().keys({
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
  }),
};

const resendForgotPasswordOtp = {
  body: Joi.object().keys({
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
  }),
};

const verifyForgotPasswordOtp = {
  body: Joi.object().keys({
    otp: Joi.number()
      .strict()
      .integer()
      .min(100000)
      .max(999999)
      .required()
      .messages({
        "number.base": "OTP must be a number",
        "number.min": "OTP must be a 6-digit number",
        "number.max": "OTP must be a 6-digit number",
        "any.required": "OTP is required",
      }),
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
  }),
};

const resetPassword = {
  body: Joi.object().keys({
    email: Joi.string().email().required().messages({
      "string.base": "Email must be a string",
      "string.email": "Email must be a valid email address",
      "any.required": "Email is required",
      "string.empty": "Email cannot be empty",
    }),
    newPassword: Joi.string().required().messages({
      "string.base": "newPassword must be a string",
      "any.required": "newPassword is required",
      "string.empty": "newPassword cannot be empty",
    }),
    conformNewPassword: Joi.string()
      .valid(Joi.ref("newPassword"))
      .required()
      .messages({
        "any.only": "conformNewPassword must match newPassword",
        "any.required": "conformNewPassword is required",
      }),
  }),
};

const loginByApple = {
  body: Joi.object({
    token: Joi.string().required().messages({
      "string.base": "Token must be a string",
      "any.required": "Token is required",
      "string.empty": "Token cannot be empty",
    }),
  }),
};

const loginByGoogle = {
  body: Joi.object({
    token: Joi.string().required().messages({
      "string.base": "Identity Token must be a string",
      "any.required": "Identity Token is required",
      "string.empty": "Identity Token cannot be empty",
    }),
  }),
};

const verifyMobileOtp = {
  body: Joi.object().keys({
    otp: Joi.number()
     .strict()
     .integer()
     .min(100000)
     .max(999999)
     .required()
     .messages({
        "number.base": "OTP must be a number",
        "number.min": "OTP must be a 6-digit number",
        "number.max": "OTP must be a 6-digit number",
        "any.required": "OTP is required",
      }),
      mobileNumber: Joi.number().strict().required().messages({
      "number.base": "MobileNumber must be a number",
      "any.required": "MobileNumber is required",
    }),
  }),
}

const resendMobileOtp = {
  body: Joi.object().keys({
    mobileNumber: Joi.number().strict().required().messages({
      "number.base": "Backup MobileNumber must be a number",
      "any.required": "Backup MobileNumber is required",
    }),
    type: Joi.string().required().messages({
      "string.base": "Type must be a string",
      "any.required": "Type is required",
      "string.empty": "Type cannot be empty",
    }),
  }),
}

export default {
  verifyToken,
  registerByEmail,
  loginByEmail,
  forgotPassword,
  resendEmailOtp,
  verifyEmailOtp,
  resendForgotPasswordOtp,
  verifyForgotPasswordOtp,
  resetPassword,
  loginByGoogle,
  loginByApple,
  verifyMobileOtp,
  resendMobileOtp
};
