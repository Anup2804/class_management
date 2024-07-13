import mongoose, { Schema } from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const teacherSchema = new mongoose.Schema(
  {
    fullName: {
      type: String,
      required: true,
      trim: true,
    },
    qualification: {
      type: String,
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
    hiredForSubject: {
      type: [String],
      default: ["All"],
    },
    hiredForStandard: {
      type: [String],
    },
    refreshToken: {
      type: String,
    },
  },
  { timestamps: true }
);

teacherSchema.pre("save", async function (next) {
  if (!this.isModified("password")) return next();

  this.password = await bcrypt.hash(this.password, 10);
  next();
});

teacherSchema.methods.isPasswordCorrect = async function (password) {
  return await bcrypt.compare(password, this.password);
};

teacherSchema.methods.generateAccessToken = function () {
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

teacherSchema.methods.generateRefreshToken = function () {
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

export const teachers = mongoose.model("teachers", teacherSchema);
