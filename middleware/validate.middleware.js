import Joi from "joi";
import { StatusCodes } from "http-status-codes";
import { validateResponse } from "../helper/api-response.helper.js";

/**
 * Picks specific keys from an object
 */
const pick = (object, keys) => {
  return keys.reduce((obj, key) => {
    if (object && Object.prototype.hasOwnProperty.call(object, key)) {
      obj[key] = object[key];
    }
    return obj;
  }, {});
};

/**
 * Middleware to validate request data, including `multipart/form-data`
 */
const validate = (schema) => (req, res, next) => {
  const validSchema = pick(schema, ["params", "query", "body", "files"]);

  if (req.file) {
    req.files = { agreementUrl: req.file };
  }
  if (!req.files) req.files = {};

  const object = pick(req, Object.keys(validSchema));
  const { value, error } = Joi.compile(validSchema)
    .prefs({ errors: { label: "key" }, abortEarly: false })
    .validate(object);

  if (error) {
    return validateResponse({
      res,
      error,
      statusCode: StatusCodes.BAD_REQUEST,
    });
  }

  Object.assign(req, value);
  return next();
};

export default validate;
