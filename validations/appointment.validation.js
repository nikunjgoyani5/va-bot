import Joi from "joi";

const appointmentValidationSchema = {
  body: Joi.object().keys({
    client: Joi.object()
      .keys({
        name: Joi.string().required().messages({
          "any.required": "Client name is required",
          "string.empty": "Client name cannot be empty",
          "string.base": "Client name must be a string",
        }),
        email: Joi.string().email().required().messages({
          "any.required": "Client email is required",
          "string.empty": "Client email cannot be empty",
          "string.base": "Client email must be a string",
          "string.email": "Client email must be a valid email",
        }),
        phone: Joi.string().required().messages({
          "any.required": "Client phone number is required",
          "string.empty": "Client phone number cannot be empty",
          "string.base": "Client phone number must be a string",
        }),
      })
      .required()
      .messages({
        "any.required": "Client details are required",
      }),

    appointmentType: Joi.string()
      .valid("meeting", "property showing")
      .required()
      .messages({
        "any.required": "Appointment type is required",
        "string.empty": "Appointment type cannot be empty",
        "string.base": "Appointment type must be a string",
        "any.only":
          "Appointment type must be either 'meeting' or 'property showing'",
      }),

    date: Joi.date().iso().required().messages({
      "any.required": "Appointment date is required",
      "date.base": "Appointment date must be a valid date",
      "date.format": "Appointment date must be in ISO format (YYYY-MM-DD)",
    }),

    time: Joi.string().required().messages({
      "any.required": "Appointment time is required",
      "string.empty": "Appointment time cannot be empty",
      "string.base": "Appointment time must be a string",
    }),

    propertyAddress: Joi.string().optional().allow("").messages({
      "string.base": "Property address must be a string",
    }),

    notes: Joi.string().optional().allow("").messages({
      "string.base": "Notes must be a string",
    }),

    image: Joi.string().optional().allow("").messages({
      "string.base": "Image URL must be a string",
    }),

    status: Joi.string()
      .valid("pending", "cancelled", "rescheduled", "missed")
      .default("pending")
      .messages({
        "string.base": "Status must be a string",
        "any.only":
          "Status must be one of 'pending', 'cancelled', 'rescheduled', or 'missed'",
      }),

    rescheduledFrom: Joi.string().optional().allow(null, "").messages({
      "string.base": "RescheduledFrom must be a valid ID",
    }),
  }),
};

export default {
    appointmentValidationSchema
};
