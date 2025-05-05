import upload from "../config/multer.config.js";
import validate from "../middleware/validate.middleware.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";
import offerValidation from "../validations/offer.validation.js";
import offerController from "../controllers/offer.controller.js";
import express from "express";

const route = express.Router();

route.post(
  "/create-offer",
  verifyToken,
  upload.single("agreementUrl"),
  validate(offerValidation.createOffer),
  offerController.createOffer
);

route.get("/get-offer/:id?", verifyToken, offerController.getOffers);
route.patch(
  "/update-offer/:offerId",
  verifyToken,
  upload.single("agreementUrl"),
  offerController.updateOffer
);

export default route;
