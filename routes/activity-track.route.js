import express from 'express';
import { verifyToken } from '../middleware/verify-token.middleware.js';
import activityController from '../controllers/activity-track.controller.js';

const route = express.Router();

route.get(
    "/list", 
    verifyToken, 
    activityController.getActivityByUser
);

export default route;