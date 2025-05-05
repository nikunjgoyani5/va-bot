import twilio from "twilio";
import User from "../models/user.model.js";
import config from "../config/config.js";
import { StatusCodes } from "http-status-codes";
import { apiResponse } from "../helper/api-response.helper.js";
import helper from "../helper/common.helper.js";

const client = new twilio(config.twilio.accountSid, config.twilio.authToken);

const fetchAvailableNumbers = async (countryCode, limit = 10) => {
  return client.availablePhoneNumbers(countryCode).local.list({ limit });
};

const buyTwilioNumber = async (req, res, returnData = false) => {
  try {
    const { id: userId } = req.user || {};
    const { number, countryCode } = req.query;

    console.log(`Fetching available numbers for country: ${countryCode}`);
    const availableNumbers = await fetchAvailableNumbers(countryCode);

    const isNumberAvailable = availableNumbers.some(
      ({ phoneNumber }) => phoneNumber === number
    );

    if (!isNumberAvailable) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: `Requested number ${number} is not available for purchase!`,
        status: false,
        data: null,
      });
    }

    console.log(`Purchasing number: ${number}`);
    const purchasedNumber = await client.incomingPhoneNumbers.create({
      phoneNumber: number,
    });

    console.log(
      `Updating user ${userId} with new Twilio number: ${purchasedNumber.phoneNumber}`
    );
    const updatedUser = await User.findByIdAndUpdate(
      userId,
      { twilioNumber: purchasedNumber.phoneNumber },
      { new: true }
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Twilio Number Purchased & Assigned Successfully!",
      status: true,
      data: { twilioNumber: purchasedNumber.phoneNumber, user: updatedUser },
    });
  } catch (error) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Internal Server Error!",
      status: false,
      data: null,
    });
  }
};

const getAvailableNumbers = async (req, res) => {
  try {
    const { countryCode } = req.query;

    console.log(`Fetching available numbers for ${countryCode}`);
    const availableNumbers = await fetchAvailableNumbers(countryCode);

    const numberList = availableNumbers.map(
      ({ phoneNumber, region, capabilities }) => ({
        phoneNumber,
        region,
        capabilities,
      })
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: `Available Twilio Numbers for ${countryCode}`,
      status: true,
      data: { numbers: numberList },
    });
  } catch (error) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Internal Server Error!",
      status: false,
      data: null,
    });
  }
};

const getSupportedCountries = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    const { skip, limit: perPageLimit } = helper.paginationFun({ page, limit });

    console.log("Fetching Twilio supported countries...");
    const countries = await client.pricing.phoneNumbers.countries.list();

    if (!countries.length) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "No supported countries found!",
        status: false,
        data: null,
      });
    }

    const totalItems = countries.length;
    const pagination = helper.paginationDetails({
      page,
      totalItems,
      limit: perPageLimit,
    });

    const countryList = countries
      .slice(skip, skip + perPageLimit)
      .map(({ country, isoCountry }) => ({
        countryName: country,
        countryCode: isoCountry,
      }));

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Supported Twilio Countries",
      status: true,
      data: { countryList, pagination },
    });
  } catch (error) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Internal Server Error!",
      status: false,
      data: null,
    });
  }
};

export default {
  buyTwilioNumber,
  getAvailableNumbers,
  getSupportedCountries,
};
