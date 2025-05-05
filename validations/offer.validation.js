import Joi from "joi";

const partySchema = Joi.object({
  name: Joi.string().required(),
  email: Joi.string().email().required(),
  phone: Joi.string().required(),
  address: Joi.string().required(),
  offeredprice: Joi.number().required(),
  brokername: Joi.string().required(),
  brokeragePercentage: Joi.number().required(),
});

const propertySchema = Joi.object({
  type: Joi.string().required(),
  location: Joi.string().required(),
  ownershiptype: Joi.string().required(),
  image: Joi.string().required(),
});

const createOffer = {
  body: Joi.object({
    createdby: Joi.string().hex().length(24).optional(),
    seller: Joi.array().items(partySchema).min(1).required(),
    buyer: Joi.array().items(partySchema).min(1).required(),
    property: Joi.array().items(propertySchema).min(1).required(),
    status: Joi.string().optional(),
  }),
  files: Joi.object({
    agreementUrl: Joi.object().optional(),
  }),
};

export default { createOffer };
