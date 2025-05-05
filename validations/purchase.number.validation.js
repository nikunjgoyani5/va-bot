import Joi from "joi";

const buyTwilioNumber = {
  query: Joi.object({
    number: Joi.string().required(),
    countryCode: Joi.string().required(),
  }),
};

const getAvailableNumbers = {
  query: Joi.object({
    countryCode: Joi.string().required(),
  }),
};

export default {
  buyTwilioNumber,
  getAvailableNumbers,
};
