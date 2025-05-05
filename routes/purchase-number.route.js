import express from "express";
import purchaseNumberController from "../controllers/purchase.number.controller.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";
import validate from "../middleware/validate.middleware.js";
import validation from "../validations/purchase.number.validation.js";

const router = express.Router();

router.post(
  "/buy-number",
  verifyToken,
  validate(validation.buyTwilioNumber),
  purchaseNumberController.buyTwilioNumber
);
router.get(
  "/country-wise-number",
  validate(validation.getAvailableNumbers),
  purchaseNumberController.getAvailableNumbers
);
router.get("/get-country-list", purchaseNumberController.getSupportedCountries);

export default router;
