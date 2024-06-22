import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { students } from "../model/student.model.js";
import { apiResponse } from "../utils/apiResponse.js";

const generateAccessTokenAndRefreshToken = async (userId) => {
  // This function generates the access token for user after login.
  try {
    const student = await students.findById(userId);
    const generateAccessToken = student.generateAccessToken();
    const generateRefreshToken = student.generateRefreshToken();

    student.refreshToken = generateRefreshToken;
    await student.save({ validateBeforeSave: false });

    return { generateAccessToken, generateRefreshToken };
  } catch (err) {
    throw new apiError(500, "something went worng");
  }
};

const studentRegister = asyncHandler(async (req, res) => {
  // take the inputs from user.
  // validate the user input.
  // find user exist or not in the database.
  // if user not exist create the user.
  const {
    fullName,
    email,
    password,
    standard,
    schoolName,
    phoneNo,
    subjectChosen,
  } = req.body;

  if (!email && !password) {
    throw new apiError(402, "email or password are required.");
  }

  if (!fullName && !standard && !schoolName && !phoneNo && !subjectChosen) {
    throw new apiError(402, "all fields with star mark are required.");
  }

  const existingStudent = await students.findOne({ email });

  if (existingStudent) {
    throw new apiError(402, "user with email already exist.");
  }

  const subjects = JSON.parse(req.body.subjectChosen);

  const newStudent = await students.create({
    fullName,
    email,
    password,
    standard,
    schoolName,
    phoneNo,
    subjectChosen: subjects,
  });

  const student = await students
    .findOne(newStudent._id)
    .select("-password -refreshtoken");

  if (!student) {
    throw new apiError(500, "unable to register student.");
  }

  return res.status(200).json(new apiResponse(200, student, "user created."));
});

const studentLogin = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  if (!email && !password) {
    throw new apiError(402, "email or password is required.");
  }

  const getStudent = await students.findOne({ email });

  if (!getStudent) {
    throw new apiError(402, "user with email does not exist.");
  }

  const passwordValid = await getStudent.isPasswordCorrect(password);

  if (!passwordValid) {
    throw new apiError(404, "password is invaild.");
  }

  const { generateAccessToken, generateRefreshToken } =
    await generateAccessTokenAndRefreshToken(getStudent._id);

  const loggedInStudent = await students.findById(getStudent._id).select(
    "-password -refreshtoken"
  );

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
        {  sutdentDetails:loggedInStudent, generateAccessToken, generateRefreshToken },
        "user login successful."
      )
    );
});

export { studentRegister, studentLogin };
