import { StatusCodes } from "http-status-codes";
import { apiResponse } from "../helper/api-response.helper.js";
import Offer from "../models/offer.model.js";
import fileUploadService from "../services/file.upload.service.js";
import emailService from "../services/email.service.js";
import config from "../config/enum.config.js";

const createOffer = async (req, res) => {
  try {
    req.body.createdby = req.user.id;

    if (req.file) {
      const buffer = req.file.buffer;
      const mimetype = req.file.mimetype;

      const agreementUrl = await fileUploadService.uploadFile({
        mimetype,
        buffer,
        folder: config.bucketFolderEnum.OFFER,
      });

      req.body.agreementUrl = agreementUrl;
    }

    const buyerEmail =
      req.body.buyer &&
      Array.isArray(req.body.buyer) &&
      req.body.buyer.length > 0
        ? req.body.buyer[0].email
        : null;

    if (buyerEmail && !validateEmail(buyerEmail)) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "Invalid buyer email format.",
        success: false,
      });
    }
    req.body.status = config.OfferManagmentEnum.WAITING_FOR_SIGNATURE;

    const offer = await Offer.create(req.body);

    if (buyerEmail) {
      await emailService.dynamicSendGmail({
        to: buyerEmail,
        subject: "New Offer Agreement",
        body: `Hello, we have sent you an offer agreement. Please check: ${req.body.agreementUrl}`,
        user: req.user,
      });
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.CREATED,
      data: offer,
      message: "Offer created successfully & email sent!",
      success: true,
    });
  } catch (error) {
    console.error("Error creating offer:", error);

    return apiResponse({
      res,
      error,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "An error occurred while creating the offer.",
    });
  }
};

const validateEmail = (email) => {
  const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
  return emailRegex.test(email);
};

const getOffers = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    let offers;

    if (id) {
      offers = await Offer.findOne({ _id: id, createdby: userId });
      if (!offers) {
        return apiResponse({
          res,
          statusCode: StatusCodes.NOT_FOUND,
          message: "Offer not found or access denied.",
          success: false,
        });
      }
    } else {
      offers = await Offer.find({ createdby: userId });
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      data: offers,
      message: "Offers retrieved successfully.",
      success: true,
    });
  } catch (error) {
    console.error("Error fetching offers:", error);
    return apiResponse({
      res,
      error,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "An error occurred while fetching offers.",
    });
  }
};

const updateOffer = async (req, res) => {
  try {
    const { offerId } = req.params;

    let offer = await Offer.findById(offerId);
    if (!offer) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "Offer not found.",
        success: false,
      });
    }

    if (req.file) {
      const buffer = req.file.buffer;
      const mimetype = req.file.mimetype;

      const agreementUrl = await fileUploadService.uploadFile({
        mimetype,
        buffer,
        folder: config.bucketFolderEnum.OFFER,
      });

      req.body.agreementUrl = agreementUrl;
    }

    const buyerEmail =
      req.body.buyer &&
      Array.isArray(req.body.buyer) &&
      req.body.buyer[0]?.email;

    if (buyerEmail && !validateEmail(buyerEmail)) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "Invalid buyer email format.",
        success: false,
      });
    }

    if (req.body.seller && Array.isArray(req.body.seller)) {
      req.body.seller.forEach((newSeller, idx) => {
        offer.seller[idx] = {
          ...offer.seller[idx]._doc,
          ...newSeller,
        };
      });
    }

    if (req.body.buyer && Array.isArray(req.body.buyer)) {
      req.body.buyer.forEach((newBuyer, idx) => {
        offer.buyer[idx] = {
          ...offer.buyer[idx]._doc,
          ...newBuyer,
        };
      });
    }

    if (req.body.property && Array.isArray(req.body.property)) {
      req.body.property.forEach((newProp, idx) => {
        offer.property[idx] = {
          ...offer.property[idx]._doc,
          ...newProp,
        };
      });
    }

    const excludeFields = ["seller", "buyer", "property"];
    Object.keys(req.body).forEach((key) => {
      if (!excludeFields.includes(key)) {
        offer[key] = req.body[key];
      }
    });

    await offer.save();

    if (buyerEmail && req.body.agreementUrl) {
      await emailService.dynamicSendGmail({
        to: buyerEmail,
        subject: "Updated Offer Agreement",
        body: `Hello, the offer agreement has been updated. Please check: ${req.body.agreementUrl}`,
        user: req.user,
      });
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      data: offer,
      message: "Offer updated successfully.",
      success: true,
    });
  } catch (error) {
    console.error("Error updating offer:", error);
    return apiResponse({
      res,
      error,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "An error occurred while updating the offer.",
    });
  }
};

export default {
  createOffer,
  getOffers,
  updateOffer,
};
