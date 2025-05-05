import Joi from "joi";

const buyNumberValidation = {
  query: Joi.object({
    number: Joi.string().required().messages({
      "any.required": "Phone number is required",
      "string.empty": "Phone number cannot be empty",
    }),
    countryCode: Joi.string().required().messages({
      "any.required": "Country code is required",
      "string.empty": "Country code cannot be empty",
    }),
  }),
};

export default {
  buyNumberValidation,
};
