import mongoose, { Schema } from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const subjectChosen = new mongoose.Schema({
  subjectName: {
    type: String,
  },
});

const studentSchema = new mongoose.Schema(
  {
    fullName: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
    passwrod: {
      type: String,
      required: true,
    },
    class: {
      type: String,
      required: true,
    },
    schoolName: {
      type: String,
      required: true,
    },
    subjectChosen: {
      type: [subjectChosen],
      default: "all",
    },
    address: {
      type: String,
      required: true,
    },
    phoneNo: {
      type: String,
      required: true,
    },
  },{timestamps: true,}
);

studentSchema.pre("save", async function (next) {
  if (!this.isModified("passwrod")) return next();

  this.passwrod = await bcrypt.hash(this.passwrod, 10);
  next();
});

studentSchema.methods.isPasswordCorrect = async function (password) {
  return await bcrypt.compare(password, this.password);
};

studentSchema.methods.generateAccessToken = function () {
  return jwt.sign(
    {
      _id: this._id,
      fullName: this.fullName,
      email: this.email,
      class:this.class
    },
    process.env.ACCESS_TOKEN_SECRET,
    {
      expiresIn: process.env.ACCESS_TOKEN_EXPIRY,
    }
  );
};

studentSchema.methods.generateRefreshToken = function () {
  return jwt.sign(
    {
      _id: this._id,
      // fullName: this.fullName,
      // email: this.email,
    },
    process.env.REFRESH_TOKEN_SECRET,
    {
      expiresIn: process.env.REFRESH_TOKEN_EXPIRY,
    }
  );
};

export const students = mongoose.model("students", studentSchema);
