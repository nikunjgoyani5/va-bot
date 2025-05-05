import express from "express";
import  callingController  from "../controllers/calling.controller.js";

const router = express.Router();

router.post("/incoming-call", callingController.handleIncomingCall);
router.post("/make-call", callingController.makeCall);
router.get("/get-recordings", callingController.getAllRecordings);

export default router;
