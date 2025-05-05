import activityModel from '../models/activity-track.model.js';
import UserModel from '../models/user.model.js';
import helper from '../helper/common.helper.js';

export const createActivity = async (data) => {
    try {
        let { userId, email, category, activityType, description, activityData , status = false, error = "" , errorMessage } = data;
        userId = await helper.ensureUserId(userId, email); 

        const activityEntry = { activityType, description, activityData , status, error , errorMessage };
        let userActivity = await activityModel.findOne({ userId });

        if (!userActivity) {
            userActivity = new activityModel({
                userId,
                email,
                activities: new Map([[category, [activityEntry]]]) 
            });
        } else {
            if (!userActivity.activities.has(category)) {
                userActivity.activities.set(category, []);
            }
        
            userActivity.activities.get(category).push(activityEntry);
            userActivity.markModified('activities'); 
        }

        await userActivity.save();
        return userActivity;

    } catch (error) {
        console.error("Error creating activity:", error.message);
        try {
            await activityModel.create({
                userId: "System",
                email: "System",
                activities: {
                    system: [{
                        activityType: "System Error",
                        description: "Failed to log activity",
                        status: false,
                        error: error.message
                    }]
                }
            });
        } catch (finalError) {
            console.error("Failed to log system error activity:", finalError.message);

        }
    }
};

const getActivityByUserId = async (userId) => {
    return await activityModel.find({ userId });
}

const getActivityByCategory = async (userId, category) => {
    return await activityModel.findOne(
        { userId, [`activities.${category}`]: { $exists: true } }, 
        { [`activities.${category}`]: 1, _id: 0 } 
    );
};

export default {
    createActivity,
    getActivityByUserId,
    getActivityByCategory
};
