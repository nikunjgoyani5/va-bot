import mongoose from 'mongoose';

const activitySchema = new mongoose.Schema(
    {
        userId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: true,
            default: null
        },
        email: {
            type: String,
            required: false,
            default: null
        },
        activities: {
            type: Map,
            of: [
                {
                    activityType: {
                        type: String,
                        required: true
                    },
                    description: {
                        type: String
                    },
                    activityData: {
                        type: Object,
                        default: {}
                    },
                    status: {
                        type: Boolean,
                        default: false
                    },
                    error: {
                        type: String
                    },
                    errorMessage : {
                        type: mongoose.Schema.Types.Mixed,
                        default: {}
                    },
                    createdAt: {
                        type: Date,
                        default: Date.now
                    }
                }
            ]
        }
    },
    { timestamps: true }
);

const activityModel = mongoose.model("Activity", activitySchema);
export default activityModel;
