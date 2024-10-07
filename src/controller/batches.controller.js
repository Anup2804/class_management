import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teachers.model.js";
import { students } from "../model/students.model.js";
import { lectures } from "../model/lecture.model.js";
import { batches } from "../model/batches.model.js";

const AddBatches = asyncHandler(async (req, res) => {
  const { lectureId } = req.params;

  if (!lectureId) {
    throw new apiError(402, "standard ,board or lecture is empty");
  }

  const lecture = await lectures.findById(lectureId);

  if (!lecture) {
    throw new apiError(405, "lecture not found.");
  }

  const standard = lecture.standard;
  const board = lecture.board;

  const student = await students.find({ standard, board });

  console.log(student);

  if (!student) {
    throw new apiError(405, `no student of ${standard} and ${board}`);
  }

  const studentDataArray = [];

student.forEach((students) => {
  studentDataArray.push({
    studentId: students.fullName,
    isPresent: false, 
  });
});

  const newBatch = await batches.create({
    StudentData: studentDataArray,
    lectureId,
    adminName: req.teacher.adminName,
    date: new Date().toISOString().split("T")[0],
    inTime: null,
    inLocation: null,
    outTime: null,
    outLocation: null,
    byTeacher: req.teacher.fullName,
  });

  return res.status(201).json({
    message: "Batch added successfully",
    batch: newBatch,
  });
});

export { AddBatches };
