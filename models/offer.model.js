import mongoose from "mongoose";
import enums from "../config/enum.config.js";

const partySchema = new mongoose.Schema(
  {
    name: { type: String, default: null },
    email: { type: String, default: null },
    phone: { type: String, default: null },
    address: { type: String, default: null },
    offeredprice: { type: Number, default: null },
    brokername: { type: String, default: null },
    brokeragePercentage: { type: Number, default: null },
  },
  { _id: false }
);
const propertySchema = new mongoose.Schema(
  {
    image: { type: String , default: null },
    type: { type: String, default: null },
    location: { type: String, default: null },
    ownershiptype: { type: String, default: null },
  },
  { _id: false }
);

const offerSchema = new mongoose.Schema(
  {
    createdby: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    agreementUrl: String,
    seller: [partySchema],
    buyer: [partySchema],
    property: [propertySchema],
    status: {
      type: String,
      enum: Object.values(enums.OfferManagmentEnum),
      default: null,
    },
  },
  { timestamps: true }
);

offerSchema.index({ createdby: 1 });
offerSchema.index({ status: 1 });

const Offer = mongoose.model("Offer", offerSchema);
export default Offer;
