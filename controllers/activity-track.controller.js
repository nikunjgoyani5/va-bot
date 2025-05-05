import { apiResponse } from "../helper/api-response.helper.js";
import { StatusCodes } from "http-status-codes";
import activityModel from "../models/activity-track.model.js";
import helperFunction from "../helper/common.helper.js";

const getActivityByUser = async (req, res) => {
    const userId = req.user.id;
    const { category, page = 1, limit = 10 } = req.query;

    try {
        const userActivity = await activityModel.findOne({ userId });

        if (!userActivity) {
            return apiResponse({
                res,
                status: true,
                message: "No activity found for this user.",
                statusCode: StatusCodes.OK,
                data: [],
            });
        }

        let activities = userActivity.activities;

        if (category) {
            activities = { [category]: activities.get(category) || [] };
        } else {
            activities = Object.fromEntries(activities);
        }

        const paginatedActivities = {};
        let totalItems = 0;

        Object.keys(activities).forEach((cat) => {
            const allActivities = activities[cat] || [];
            totalItems += allActivities.length;

            const { skip, limit: pageLimit } = helperFunction.paginationFun({ page, limit });

            paginatedActivities[cat] = allActivities.slice(skip, skip + pageLimit);
        });

        return apiResponse({
            res,
            status: true,
            message: "Activity fetched successfully.",
            statusCode: StatusCodes.OK,
            pagination: helperFunction.paginationDetails({ page, totalItems, limit }),
            data: paginatedActivities,
        });

    } catch (error) {
        console.error("Error fetching activities:", error.message);

        return apiResponse({
            res,
            status: false,
            message: "Failed to fetch activity track.",
            statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
            data: null,
        });
    }
};

export default {
    getActivityByUser,
};
