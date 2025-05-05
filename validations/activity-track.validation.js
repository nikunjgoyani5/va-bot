import Joi from 'joi';

const activityTrack = {
    body: Joi.object().keys({
        userId: Joi.string().required().messages({
            "string.base": "userId must be a string",
            "any.required": "userId is required",
            "string.empty": "userId cannot be empty",
        }),
        activityType: Joi.string().required().messages({
            "string.base": "activityType must be a string",
            "any.required": "activityType is required",
            "string.empty": "activityType cannot be empty",
        }),
        description: Joi.string().required().messages({
            "any.required": "description is required",
            "string.empty": "description cannot be empty",
        }),
    }),
};

export default {
    activityTrack,
};