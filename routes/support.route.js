import express from "express";
import supportController from "../controllers/support.controller.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";
import multer from "multer";
import validate from "../middleware/validate.middleware.js";
import supportValidation from "../validations/support.validation.js";

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

const route = express.Router();

route.post(
  "/support-request/add",
  verifyToken,
  upload.single("attachment"),
  validate(supportValidation.supportRequest),
  supportController.sendRequestToSupport
);

route.patch(
  "/support-request/:requestId/status",
  verifyToken,
  supportController.updateRequestStatus
);

route.get(
  "/support-request/list",
  verifyToken,
  supportController.getSupportRequestList
);

export default route;
