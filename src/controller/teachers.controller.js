import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teachers.model.js";
import { students } from "../model/students.model.js";
import { admins } from "../model/admins.model.js";

const generateAccessTokenAndRefreshToken = async (userId) => {
  try {
    const teacher = await teachers.findById(userId);
    const generateAccessToken = teacher.generateAccessToken();
    const generateRefreshToken = teacher.generateRefreshToken();

    teacher.refreshToken = generateRefreshToken;
    await teacher.save({ validateBeforeSave: false });

    return { generateAccessToken, generateRefreshToken };
  } catch (err) {
    throw new apiError(500, "something went worng");
  }
};

const teacherRegister = asyncHandler(async (req, res) => {
  const {
    fullName,
    qulification,
    email,
    password,
    hiredForSubject,
    hiredForStandard,
    hiredForBoard,
    staff,
    adminEmail
  } = req.body;

  if (!fullName && !email && !password && !adminEmail) {
    throw new apiError(402, "name , email and password are required.");
  }

  const existingTeacher = await teachers.findOne({ email });

  if (existingTeacher) {
    throw new apiError(402, "teacher already exist.");
  }

  const isStudent = await students.findOne({ email });

  if (isStudent) {
    throw new apiError(402, "you are not the teacher.");
  }

  const getAdmin = await admins.findOne({
    email: adminEmail,
  });

  if (!getAdmin) {
    throw new apiError(402, "admin email is incorrect");
  }

  const upperCaseHiredForBoard = Array.isArray(hiredForBoard)
    ? hiredForBoard.map(board => board.trim().toUpperCase())
    : [hiredForBoard.trim().toUpperCase()];
  
  const teacher = await teachers.create({
    fullName,
    email,
    password,
    qulification: qulification,
    hiredForStandard,
    hiredForSubject,
    hiredForBoard: upperCaseHiredForBoard,
    staff,
    adminEmail
    // hiredForStandard:Array.isArray(hiredForStandard) ? hiredForStandard: [hiredForStandard],
    // hiredForSubject:Array.isArray(hiredForSubject) ? hiredForSubject : [hiredForSubject]
  });

  const newTeacher = await teachers
    .findById(teacher._id)
    .select("-password -refreshToken");

  return res
    .status(200)
    .json(new apiResponse(200, newTeacher, "teacher created successfully "));
});

const teacherLogin = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  if (!email && !password) {
    throw new apiError(402, "email,password and fullName is required");
  }

  const getTeacher = await teachers.findOne({ email });


  if (!getTeacher) {
    throw new apiError(500, "user with this email does not exist.");
  }

  const passwordValid = await getTeacher.isPasswordCorrect(password);

  if (!passwordValid) {
    throw new apiError(500, "password is invalid");
  }

  const { generateAccessToken, generateRefreshToken } =
    await generateAccessTokenAndRefreshToken(getTeacher._id);

  const loggedInTeacher = await teachers
    .findById(getTeacher._id)
    .select("-password -refreshToken");

  const option = {
    httpOnly: true,
    secure: true,
  };

  return res
    .status(200)
    .cookie("accessToken", generateAccessToken, option)
    .cookie("refreshtoken", generateRefreshToken, option)
    .json(
      new apiResponse(
        200,
        {
          teacherDetails: loggedInTeacher,
          generateAccessToken,
          generateRefreshToken,
        },
        "user login successful."
      )
    );
});

const teacherLogout = asyncHandler(async (req, res) => {
  req.teacher._id;
  // console.log(req.user)
  await teachers.findByIdAndUpdate(
    req.teacher._id,
    {
      $set: {
        refreshToken: "",
      },
    },
    {
      new: true,
    }
  );

  const option = {
    httpOnly: true,
    secure: true,
  };

  return res
    .status(200)
    .clearCookie("accessToken", option)
    .clearCookie("refreshToken", option)
    .json(new apiResponse(200, {}, "User logout successful"));
});

export { teacherRegister, teacherLogin, teacherLogout };
