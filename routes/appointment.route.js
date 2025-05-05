import express from "express";
import appointmentController from "../controllers/appointment.controller.js";
import multer from "multer";
import validate from "../middleware/validate.middleware.js";
import appointmentValidation from "../validations/appointment.validation.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

const router = express.Router();

router.post(
  "/",
  verifyToken,
  // validate(appointmentValidation.appointmentValidationSchema),
  upload.single("image"),
  appointmentController.createAppointment
);
router.get("/", verifyToken, appointmentController.getAppointments);
router.put("/cancel/:id", verifyToken, appointmentController.cancelAppointment);
router.put("/reschedule/:id", verifyToken, appointmentController.rescheduleAppointment);

export default router;
