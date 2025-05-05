import axios from "axios";
import crypto from "crypto";
import { StatusCodes } from "http-status-codes";
import { apiResponse } from "../helper/api-response.helper.js";
import userService from "../services/user.service.js";
import config from "../config/config.js";
import jwt from "jsonwebtoken";
import qs from "qs";
import User from "../models/user.model.js";
import { console } from "inspector";

//-------------------------------- SalesForce CRM --------------------------------

const salesforceAuthRedirect = async (req, res) => {
  try {
    const codeVerifier = crypto.randomBytes(32).toString("base64url");
    const codeChallenge = crypto
      .createHash("sha256")
      .update(codeVerifier)
      .digest("base64url");

    const user = await userService.findOne({ email: req.user.email });

    if (!user) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "User not found",
        status: false,
        data: null,
      });
    }

    user.salesforceAccounts = [{ codeVerifier }];
    await user.save();

    const stateToken = jwt.sign({ email: user.email }, config.jwt.secretKey, {
      expiresIn: "10m",
    });

    const authURL = `${config.salesForceCRM.authUrl}?response_type=code&client_id=${config.salesForceCRM.clientId}&redirect_uri=${config.salesForceCRM.redirectUri}&code_challenge=${codeChallenge}&code_challenge_method=S256&state=${stateToken}`;

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Salesforce Auth Redirect URL",
      status: true,
      data: { authURL },
    });
  } catch (error) {
    console.error("Salesforce Auth Redirect Error:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to generate Salesforce auth URL",
      status: false,
      data: null,
    });
  }
};

const salesforceAuthCallback = async (req, res) => {
  try {
    const { code, state } = req.query;

    if (!code) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "Authorization code is missing!",
        status: false,
        data: null,
      });
    }

    if (!state) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "State is missing!",
        status: false,
        data: null,
      });
    }

    const decoded = jwt.verify(state, config.jwt.secretKey);
    const user = await userService.findOne({ email: decoded.email });

    if (
      !user ||
      !user.salesforceAccounts ||
      !user.salesforceAccounts[0].codeVerifier
    ) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "User not found or PKCE verification failed",
        status: false,
        data: null,
      });
    }

    const codeVerifier = user.salesforceAccounts[0].codeVerifier;

    const response = await axios.post(config.salesForceCRM.tokenUrl, null, {
      params: {
        grant_type: "authorization_code",
        client_id: config.salesForceCRM.clientId,
        client_secret: config.salesForceCRM.clientSecret,
        redirect_uri: config.salesForceCRM.redirectUri,
        code,
        code_verifier: codeVerifier,
      },
    });

    const { access_token, refresh_token, instance_url } = response.data;
    const { data: userInfo } = await axios.get(
      `${instance_url}/services/oauth2/userinfo`,
      {
        headers: { Authorization: `Bearer ${access_token}` },
      }
    );

    user.salesforceAccounts[0].accessToken = access_token;
    user.salesforceAccounts[0].refreshToken = refresh_token;
    user.salesforceAccounts[0].instanceUrl = instance_url;

    user.salesforceAccounts = [
      {
        accessToken: access_token,
        refreshToken: refresh_token,
        instanceUrl: instance_url,
        expiresIn: response.data.expires_in,
        createdAt: new Date(),
      },
    ];

    await user.save();

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Salesforce Authentication Successful",
      status: true,
      data: null,
    });
  } catch (error) {
    console.error("Salesforce Auth Error:", error);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Salesforce Authentication Failed",
      status: false,
      data: null,
    });
  }
};

const syncSalesforceAccounts = async (req, res) => {
  try {
    const user = await userService.findOne({ email: req.user.email });

    if (
      !user ||
      !user.salesforceAccounts ||
      !user.salesforceAccounts[0].accessToken
    ) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "Salesforce account not connected",
        status: false,
        data: null,
      });
    }

    const accountData = await fetchSalesforceQuery(
      user,
      "SELECT Id, Name, Industry FROM Account"
    );
    const leadData = await fetchSalesforceQuery(
      user,
      "SELECT Id, Name, Company, Status FROM Lead"
    );
    const contactData = await fetchSalesforceQuery(
      user,
      "SELECT Id, Name, Email, MailingCity ,MailingCountry, MailingPostalCode, MailingState , MailingStreet,Phone FROM Contact"
    );
    const opportunityData = await fetchSalesforceQuery(
      user,
      "SELECT Id, Name, StageName, Amount FROM Opportunity"
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Salesforce Data Synced Successfully",
      status: true,
      data: {
        accounts: accountData,
        leads: leadData,
        contacts: contactData,
        opportunities: opportunityData,
      },
    });
  } catch (error) {
    console.error("❌ Salesforce Sync Error:", error.message);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to sync Salesforce data",
      status: false,
      data: null,
    });
  }
};

const searchSalesforceContacts = async (req, res) => {
  try {
    const { search } = req.query;
    const user = await userService.findOne({ email: req.user.email });

    if (
      !user ||
      !user.salesforceAccounts ||
      !user.salesforceAccounts[0].accessToken
    ) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "Salesforce account not connected",
        status: false,
        data: null,
      });
    }

    const query = `SELECT Id, Name, Email, Phone FROM Contact WHERE Name LIKE '%${search}%'`;

    const contactData = await fetchSalesforceQuery(user, query);

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Contacts fetched successfully",
      status: true,
      data: contactData.records || [],
    });
  } catch (error) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to search contacts",
      status: false,
      data: null,
    });
  }
};

const fetchSalesforceQuery = async (user, soqlQuery) => {
  const accessToken = user.salesforceAccounts[0].accessToken;
  const instanceUrl = user.salesforceAccounts[0].instanceUrl;

  const response = await axios.get(
    `${instanceUrl}/services/data/v57.0/query?q=${encodeURIComponent(
      soqlQuery
    )}`,
    {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    }
  );

  return response.data;
};

//-------------------------------- Follow Up Boss CRM --------------------------------

const createFollowUpBossOAuthApp = async (req, res) => {
  try {
    const { redirectUris } = req.body;

    if (!redirectUris || !Array.isArray(redirectUris)) {
      return apiResponse({
        res,
        statusCode: StatusCodes.BAD_REQUEST,
        message: "redirectUris must be an array",
        status: false,
      });
    }

    const response = await axios.post(
      "https://api.followupboss.com/v1/oauthApps",
      {
        redirectUris,
      },
      {
        headers: {
          "X-System": "va-bot-174",
          "X-System-Key": "1f4df794ce243714dc5dd99a13336fbe",
          "Content-Type": "application/json",
        },
      }
    );

    return apiResponse({
      res,
      statusCode: StatusCodes.CREATED,
      message: "OAuth App created successfully",
      status: true,
      data: response.data,
    });
  } catch (error) {
    console.error(
      "FUB OAuth App Create Error:",
      error.response?.data || error.message
    );

    return apiResponse({
      res,
      statusCode: error.response?.status || StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to create Follow Up Boss OAuth App",
      status: false,
      data: error.response?.data || null,
    });
  }
};

const followUpBossAuthRedirect = async (req, res) => {
  try {
    const user = await userService.findOne({ email: req.user.email });

    if (!user) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "User not found. Please register first.",
        status: false,
        data: null,
      });
    }

    const stateToken = jwt.sign({ email: user.email }, config.jwt.secretKey, {
      expiresIn: "10m",
    });

    const authURL = `https://app.followupboss.com/oauth/authorize?response_type=code&client_id=${encodeURIComponent(
      config.followUpBoss.clientId
    )}&redirect_uri=${encodeURIComponent(
      config.followUpBoss.redirectUri
    )}&state=${encodeURIComponent(stateToken)}`;

    return apiResponse({
      res,
      statusCode: StatusCodes.CREATED,
      status: true,
      message: "Follow Up Boss auth URL generated successfully",
      data: authURL,
    });
  } catch (err) {
    console.error("Redirect error:", err);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      status: false,
      message: "Failed to generate FUB auth URL",
      data: null,
    });
  }
};

const followUpBossAuthCallback = async (req, res) => {
  try {
    const code = req.query.code;
    const state = req.query.state;

    if (!code) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "Missing `code` in query params",
        status: false,
        data: null,
      });
    }

    const clientId = config.followUpBoss.clientId;
    const clientSecret = config.followUpBoss.clientSecret;
    const redirectUri =
      config.followUpBoss.redirectUri ||
      "https://vabot.awaazeye.com/api/v1/crm/followupboss/callback";

    const basicAuth = Buffer.from(`${clientId}:${clientSecret}`).toString(
      "base64"
    );

    const tokenResponse = await axios.post(
      "https://app.followupboss.com/oauth/token",
      new URLSearchParams({
        grant_type: "authorization_code",
        code: code,
        redirect_uri: redirectUri,
        state: state || "",
      }).toString(),
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: `Basic ${basicAuth}`,
        },
      }
    );

    const { access_token, refresh_token, token_type, expires_in, id_token } =
      tokenResponse.data;

    const decoded = JSON.parse(
      Buffer.from(id_token.split(".")[1], "base64").toString()
    );
    const { email: connectedEmail, sub: userId } = decoded;

    const user = await User.findOne({ email: connectedEmail });
    if (!user) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "User not found. Please register first.",
        status: false,
        data: null,
      });
    }

    const newFubEntry = {
      accessToken: access_token,
      refreshToken: refresh_token,
      tokenType: token_type,
      expiresIn: expires_in,
      createdAt: new Date(),
      userId,
      connectedEmail,
    };

    user.followUpBossAccounts.push(newFubEntry);
    await user.save();
    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "FUB tokens saved to user successfully",
      status: true,
      data: newFubEntry,
    });
  } catch (err) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Something went wrong during FUB auth callback",
      status: false,
      data: null,
    });
  }
};

const getValidFubAccessToken = async (userId) => {
  const user = await User.findById(userId);

  if (!user || !user.followUpBossAccounts?.length) {
    throw new Error("No Follow Up Boss account connected.");
  }

  let fubAccount =
    user.followUpBossAccounts[user.followUpBossAccounts.length - 1];

  const tokenAgeSeconds =
    (Date.now() - new Date(fubAccount.createdAt).getTime()) / 1000;
  if (tokenAgeSeconds < fubAccount.expiresIn - 60) {
    return fubAccount.accessToken;
  }

  const clientId = config.followUpBoss.clientId;
  const clientSecret = config.followUpBoss.clientSecret;
  const basicAuth = Buffer.from(`${clientId}:${clientSecret}`).toString(
    "base64"
  );

  try {
    const refreshResponse = await axios.post(
      "https://app.followupboss.com/oauth/token",
      new URLSearchParams({
        grant_type: "refresh_token",
        refresh_token: fubAccount.refreshToken,
      }).toString(),
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: `Basic ${basicAuth}`,
        },
      }
    );

    const { access_token, refresh_token, expires_in } = refreshResponse.data;

    fubAccount.accessToken = access_token;
    fubAccount.refreshToken = refresh_token;
    fubAccount.expiresIn = expires_in;
    fubAccount.createdAt = new Date();

    await user.save();

    return access_token;
  } catch (err) {
    console.error(
      "❌ Failed to refresh FUB token:",
      err?.response?.data || err.message
    );
    throw new Error("Failed to refresh Follow Up Boss access token.");
  }
};

const getFollowUpBossProfile = async (req, res) => {
  try {
    const accessToken = await getValidFubAccessToken(req.user._id);

    const response = await axios.get("https://api.followupboss.com/v1/me", {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Follow Up Boss profile fetched successfully",
      status: true,
      data: response.data,
    });
  } catch (err) {
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Could not fetch Follow Up Boss profile",
      status: false,
      data: null,
    });
  }
};

const searchFollowUpBossContacts = async (req, res) => {
  try {
    const { search } = req.query;
    const user = await User.findById(req.user._id);

    if (
      !user ||
      !user.followUpBossAccounts ||
      user.followUpBossAccounts.length === 0
    ) {
      return apiResponse({
        res,
        statusCode: StatusCodes.NOT_FOUND,
        message: "Follow Up Boss account not connected",
        status: false,
        data: null,
      });
    }

    const accessToken = await getValidFubAccessToken(user._id);

    const url = "https://api.followupboss.com/v1/people";
    const response = await axios.get(url, {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
      params: search ? { query: search } : {},
    });

    let people = response.data?.people || [];

    if (search) {
      const searchLower = search.toLowerCase();
      people = people.filter((person) => {
        const fullName = person.name?.toLowerCase() || "";
        const firstName = person.firstName?.toLowerCase() || "";
        const lastName = person.lastName?.toLowerCase() || "";
        return (
          fullName.includes(searchLower) ||
          firstName.includes(searchLower) ||
          lastName.includes(searchLower)
        );
      });
    }

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: search
        ? "Filtered FUB contacts fetched successfully"
        : "All FUB contacts fetched successfully",
      status: true,
      data: people,
    });
  } catch (error) {
    console.error("❌ FUB Contact Search Error:", error.message);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to fetch Follow Up Boss contacts",
      status: false,
      data: null,
    });
  }
};

export default {
  salesforceAuthRedirect,
  salesforceAuthCallback,
  syncSalesforceAccounts,
  searchSalesforceContacts,
  followUpBossAuthRedirect,
  followUpBossAuthCallback,
  createFollowUpBossOAuthApp,
  getFollowUpBossProfile,
  searchFollowUpBossContacts,
};
