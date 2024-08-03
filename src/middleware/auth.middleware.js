import { apiError } from "../utils/apiError.js";
import { asyncHandler } from "../utils/asyncHandler.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { students } from "../model/students.model.js";
import { teachers } from "../model/teachers.model.js";
import { admins } from "../model/admins.model.js";
dotenv.config();

export const verifyJwtStudent = asyncHandler(async (req, _, next) => {
  try {
    const token =
      req.cookies?.accessToken ||
      req.header("Authorization")?.replace("Bearer ", "");
    // console.log(token)

    if (!token) {
      throw new apiError(401, "unauthorized request");
    }
    const decodedtoken = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);

    // console.log(decodedtoken)

    const student = await students.findById(decodedtoken?._id).select(
      "-password -refreshtoken"
    );

    if (!student) {
      throw new apiError(401, "invaild accesstoken");
    }

    req.student = student;
    //   console.log(req.user);
    next();
  } catch (error) {
    throw new apiError(401, "invalid accesstoken");
  }
});

export const verifyJwtTeacher = asyncHandler(async (req, _, next) => {
  try {
    const token =
      req.cookies?.accessToken ||
      req.header("Authorization")?.replace("Bearer ", "");
    // console.log(token)

    if (!token) {
      throw new apiError(401, "unauthorized request");
    }
    const decodedtoken = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);

    // console.log(decodedtoken)

    const teacher = await teachers.findById(decodedtoken?._id).select(
      "-password -refreshToken"
    );

    if (!teacher) {
      throw new apiError(401, "invaild accesstoken");
    }

    req.teacher = teacher;
    //   console.log(req.user);
    next();
  } catch (error) {
    throw new apiError(401, "invalid accesstoken");
  }
});

export const verifyJwtAdmin = asyncHandler(async (req, _, next) => {
  try {
    const token =
      req.cookies?.accessToken ||
      req.header("Authorization")?.replace("Bearer ", "");
    // console.log(token)

    if (!token) {
      throw new apiError(401, "unauthorized request");
    }
    const decodedtoken = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);

    // console.log(decodedtoken)

    const admin = await admins.findById(decodedtoken?._id).select(
      "-password -refreshToken"
    );

    if (!admin) {
      throw new apiError(401, "invaild accesstoken");
    }

    req.admin = admin;
    //   console.log(req.user);
    next();
  } catch (error) {
    throw new apiError(401, "invalid accesstoken");
  }
});
