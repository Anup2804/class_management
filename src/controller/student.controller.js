import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { students } from "../model/student.model.js";
import { apiResponse } from "../utils/apiResponse.js";

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
    subjectChosen:subjects,
  });

  const student = await students
    .findOne(newStudent._id)
    .select("-password -refreshtoken");

  if (!student) {
    throw new apiError(500, "unable to register student.");
  }

  return res.status(200).json(new apiResponse(200, student, "user created."));
});

export { studentRegister };
