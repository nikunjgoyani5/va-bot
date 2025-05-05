import express from "express";
import  calenderController  from "../controllers/calendar.controller.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";

const router = express.Router();

// google calender
router.post("/create-google-calendar", verifyToken, calenderController.createGoogleCalendar);

// outlook calender
router.post("/create-outlook-calendar", verifyToken, calenderController.createOutlookCalendar);

export default router;