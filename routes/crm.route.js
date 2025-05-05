import express from "express";
import crmController from "../controllers/crm.controller.js";
import { verifyToken } from "../middleware/verify-token.middleware.js";
import validate from "../middleware/validate.middleware.js";
import crmValidation from "../validations/crm.validation.js";

const router = express.Router();

// ---------------------------- Salesforce CRM ----------------------------

// Step 1: Redirect user to Salesforce for authentication
router.get(
  "/salesforce/auth",
  verifyToken,
  crmController.salesforceAuthRedirect
);

// Step 2: Callback to handle Salesforce OAuth
router.get("/salesforce/callback", crmController.salesforceAuthCallback);

// Step 3: Sync Salesforce account
router.get(
  "/salesforce/profile",
  verifyToken,
  crmController.syncSalesforceAccounts
);

// Step 4: Search Salesforce contacts (filtered or full list)
router.get(
  "/salesforce/contacts/search",
  verifyToken,
  validate(crmValidation.searchSalesforceContacts),
  crmController.searchSalesforceContacts
);

// -------------------------- Follow Up Boss CRM --------------------------

// Step 1: Redirect user to Follow Up Boss for authentication
router.get(
  "/followupboss/auth",
  verifyToken,
  crmController.followUpBossAuthRedirect
);

// Step 2: Callback for FUB OAuth
router.get("/followupboss/callback", crmController.followUpBossAuthCallback);

// Step 3: Create OAuth App (if applicable)
router.post(
  "/followupboss/oauth-app",
  crmController.createFollowUpBossOAuthApp
);

// Step 4: Get connected profile info
router.get(
  "/followupboss/profile",
  verifyToken,
  crmController.getFollowUpBossProfile
);

// Step 5: Search FUB contacts (filtered or full list)
router.get(
  "/followupboss/contacts/search",
  verifyToken,
  crmController.searchFollowUpBossContacts
);

export default router;
