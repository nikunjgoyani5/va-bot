import Joi from "joi";

const searchSalesforceContacts = {
  query: Joi.object({
    search: Joi.string().required(),
  }),
};

export default {
  searchSalesforceContacts,
};
