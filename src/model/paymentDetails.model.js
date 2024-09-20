import mongoose, { Schema, mongo } from "mongoose";

const PaymentSchema = new mongoose.Schema(
  {
    adminName: {
      type: String,
      trim: true,
      lowercase: true,
      required: true,
    },
    teacherId: {
      type: Schema.Types.ObjectId,
      ref: "teachers",
    },
    studentId: {
      type: Schema.Types.ObjectId,
      ref: "students",
    },
    paymentType: {
      type: String,
      required: true,
    },
    amount: {
      type: Number,
      required: true,
    },
    currency: {
      type: Number,
      required: true,
    },
    razorpayOrderId: {
      type: String,
      required: true,
    },
    razorpayPaymentId: {
      type: String,
      required: true,
    },
    razorpaySignature: {
      type: String,
      required: true,
    },
    paymentDate: {
      type: String,
      required: true,
    },
    dueDate: {
      type: String,
    },
    paymentStatus: {
      type: String,
      required: true,
    },
    transaction: {
      type: String,
    },
  },
  { timestamps: true }
);

const PaymentDetails = new mongoose.model("PaymentDetails", PaymentSchema);
