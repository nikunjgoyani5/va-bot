import express from "express";
import mlsController from "../controllers/mls.controller.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";

const router = express.Router();

//--------------------------- Realtyfeed Routes -----------------------------
router.get("/realtyfeed/property-list", verifyToken, mlsController.getRealtyFeedPropertyList);
router.get("/realtyfeed/property-detail/:id", verifyToken, mlsController.getRealtyFeedPropertyDetails);

export default router;
