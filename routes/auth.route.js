import validate from "../middleware/validate.middleware.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";
import authController from "../controllers/auth.controller.js";
import authValidation from "../validations/auth.validation.js";
import express from "express";

const route = express.Router();

route.post("/verify/token", verifyToken, authController.verifyToken);

route.post("/register-by-email", validate(authValidation.registerByEmail), authController.registerByEmail);

route.post("/verify-email-otp", validate(authValidation.verifyEmailOtp), authController.verifyEmailOtp);

route.post("/verify-mobile-otp", validate(authValidation.verifyMobileOtp), authController.verifyMobileOtp);

route.post("/resend-email-otp", validate(authValidation.resendEmailOtp), authController.resendEmailOtp);

route.post("/resend-mobile-otp", validate(authValidation.resendMobileOtp), authController.resendMobileOtp);

route.post("/login-by-email", validate(authValidation.loginByEmail), authController.loginByEmail);

route.post("/forgot-password", validate(authValidation.forgotPassword), authController.forgotPassword);

route.post("/google-login", validate(authValidation.loginByGoogle), authController.loginByGoogle);

route.post("/apple-login", validate(authValidation.loginByApple), authController.loginByApple);

route.post("/reset-password", validate(authValidation.resetPassword), authController.resetPassword);

//webhook route || if routes change don't forget to change in google console
route.get("/google", authController.getGoogleAuthURL);

route.get("/google/callback", authController.googleAuthCallback);

route.get("/google/sync-calendar", verifyToken, authController.syncGoogleCalendar);

route.get("/outlook", verifyToken, authController.outlookAuthUrl);

route.get("/outlook/callback", authController.outlookAuthCallback);

route.get("/outlook/sync-calendar", verifyToken, authController.syncOutlookCalendar);

export default route;
