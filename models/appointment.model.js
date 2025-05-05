import mongoose from "mongoose";
import enums from "../config/enum.config.js";

const appointmentSchema = new mongoose.Schema(
  {
    client: {
      name: { type: String },
      email: { type: String },
      phone: { type: String },
    },
    appointmentType: {
      type: String,
      enum: Object.values(enums.appointmentTypeEnum),
    },
    startTime: { type: Date },
    endTime: { type: Date },
    propertyAddress: { type: String },
    notes: { type: String },
    image: { type: String },
    googleCalendarId: { type: String },
    outlookCalendarId: { type: String },
    status: {
      type: String,
      enum: Object.values(enums.appointmentStatusEnum),
      default: enums.appointmentStatusEnum.PENDING,
    },
    rescheduledFrom: { type: mongoose.Schema.Types.ObjectId, ref: "Appointment", default: null },
    isMissed: { type: Boolean, default: false },
  },
  { timestamps: true }
);

// Mark appointment as MISSED if expired
appointmentSchema.methods.markAsMissed = async function () {
  if (this.status === enums.appointmentStatusEnum.PENDING) {
    this.status = enums.appointmentStatusEnum.MISSED;
    this.isMissed = true;
    await this.save();
    console.log(`Appointment ${this._id} marked as MISSED`);
  }
};

const Appointment = mongoose.model("Appointment", appointmentSchema);

// Change Stream to detect updates
const appointmentStream = Appointment.watch();

appointmentStream.on("change", async (change) => {
  try {
    if (change.operationType === "insert" || change.operationType === "update") {
      const appointment = await Appointment.findById(change.documentKey._id);

      if (appointment && appointment.status === enums.appointmentStatusEnum.PENDING) {
        const now = new Date();

        // Check if appointment time has already passed
        if (appointment.endTime <= now) {
          await appointment.markAsMissed();
        }
      }
    }
  } catch (error) {
    console.error("Error in change stream:", error);
  }
});

// Background Job Without Cron: Check expired appointments every 30 seconds
// setInterval(async () => {
//   try {
//     const now = new Date();
//     const expiredAppointments = await Appointment.find({
//       status: enums.appointmentStatusEnum.PENDING,
//       endTime: { $lt: now },
//     });

//     for (const appointment of expiredAppointments) {
//       await appointment.markAsMissed();
//     }
//   } catch (error) {
//     console.error("Error updating expired appointments:", error);
//   }
// }, 30 * 1000);

export default Appointment;