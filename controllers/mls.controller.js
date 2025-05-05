import axios from "axios";
import { StatusCodes } from "http-status-codes";
import { apiResponse } from "../helper/api-response.helper.js";
import qs from "qs";

const REALTYFEED_BASE_URL = "https://api.realtyfeed.com/reso/odata";
const TOKEN_URL = "https://realtyfeed-sso.auth.us-east-1.amazoncognito.com/oauth2/token";
const CLIENT_ID = "1jj5hs9dkkdtfrvljc0i0qkvoc";
const CLIENT_SECRET = "dtpq48veusf4ckc9hn3tj1k20k1290l1quts5oolpgukprl8dil";

let accessToken = null;
let tokenExpiry = 0;

// Function to get a new access token
const generateAccessToken = async () => {
  try {
    const data = qs.stringify({
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      grant_type: "client_credentials",
    });

    const response = await axios.post(TOKEN_URL, data, {
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
    });

    accessToken = response.data.access_token;

    tokenExpiry = Date.now() + response.data.expires_in * 1000;
    console.log("New access token generated");
  } catch (error) {
    console.error("Error generating access token:", error.message);
    throw error;
  }
};

// Middleware to ensure a valid token before making API calls
const ensureValidToken = async () => {
  if (!accessToken || Date.now() >= tokenExpiry) {
    await generateAccessToken();
  }
};

// Fetch list of properties
const getRealtyFeedPropertyList = async (req, res) => {
  try {
    await ensureValidToken();
    const response = await axios.get(`${REALTYFEED_BASE_URL}/Property`, {
      headers: { Authorization: `Bearer ${accessToken}` },
    });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Properties fetched successfully",
      status: true,
      data: response.data,
    });
  } catch (error) {
    console.error("RealtyFeed Properties Fetch Error:", error.message);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to fetch properties",
      status: false,
    });
  }
};

// Fetch property details by ID
const getRealtyFeedPropertyDetails = async (req, res) => {
  try {
    await ensureValidToken();
    const propertyId = req.params.id;
    const response = await axios.get(`${REALTYFEED_BASE_URL}/Property('${propertyId}')`, {
      headers: { Authorization: `Bearer ${accessToken}` },
    });

    return apiResponse({
      res,
      statusCode: StatusCodes.OK,
      message: "Property details fetched successfully",
      status: true,
      data: response.data,
    });
  } catch (error) {
    console.error("RealtyFeed Property Details Fetch Error:", error.message);
    return apiResponse({
      res,
      statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
      message: "Failed to fetch property details",
      status: false,
    });
  }
};

export default { getRealtyFeedPropertyList, getRealtyFeedPropertyDetails };
