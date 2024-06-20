import mongoose, { Schema } from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { apiError } from "../utils/apiError.js";

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
      trim: true,
      validate: {
        validator: (val) => {
          const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          return val.match(re);
        },
        message: "email not valid",
      },
    },
    password: {
      type: String,
      required: true,
      trim: true,
      validate: {
        validator: (val) => {
          const re =
            /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
          return val.match(re);
        },
        message:
          "password should contain one small letter, big letter,one number,on special character",
      },
    },
    standard: {
      type: String,
      required: true,
    },
    schoolName: {
      type: String,
      required: true,
    },
    subjectChosen: {
      type: [String],
      required:true
    },
    address: {
      type: String,
      // required: true,
    },
    phoneNo: {
      type: String,
      required: true,
      validate: {
        validator: (val) => {
          const re = /^\d{10}$/;
          return val.match(re);
        },
        message: "phone number should be of 10 digit.",
      },
    },
  },
  { timestamps: true }
);

studentSchema.pre("save", async function (next) {
  if (!this.isModified("password")) return next();

  this.password = await bcrypt.hash(this.password, 10);
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
      class: this.class,
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
