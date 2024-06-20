import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teacher.model.js";
import { students } from "../model/student.model.js";

const teacherRegister = asyncHandler(async (req, res) => {
  const { fullName, qulification, email, password, hiredForSubject } = req.body;

  if (!fullName && !email && !password) {
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

//   const hiredSubject = JSON.parse(req.body.hiredForSubject);

  const teacher = await teachers.create({
    fullName,
    email,
    password,
    qulification: qulification,
    
  });

  const newTeacher = await teachers
    .findById(teacher._id)
    .select("-password -refreshtoken");

  return res
    .status(200)
    .json(new apiResponse(200, newTeacher, "teacher created successfully "));
});

export {teacherRegister}
