import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teacher.model.js";
import { uploadoncloudnary } from "../utils/cloudnary/cloudnary.js";
import { notes } from "../model/notes.model.js";
import { students } from "../model/student.model.js";

const uploadNotes = asyncHandler(async (req, res) => {
  const { subjectName, chapterNo, standard } = req.body;

  if (!req.teacher && !mongoose.Types.ObjectId.isValid(!req.teacher._id)) {
    throw new apiError(401, "user not logged in or invalid user.");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, " user not found.");
  }

  if (!subjectName && !chapterNo && !standard) {
    throw new apiError(
      402,
      "subjectname and chapterNo and standard  is required"
    );
  }

  const notePath = req.files?.notes[0]?.path;
  if (!notePath) {
    throw new apiError(402, "notepath is empty");
  }

  const notesUrl = await uploadoncloudnary(notePath);

  if (!notesUrl) {
    throw new apiError(402, "note path is required.");
  }

  const noteFile = await notes.create({
    byTeacher: req.teacher._id,
    subjectName,
    chapterNo,
    notes: notesUrl.url,
    standard,
  });

  if (!noteFile) {
    throw new apiError(500, "unable to create a note.");
  }

  const noteData = await notes.aggregate([
    {
      $match: { _id: new mongoose.Types.ObjectId(noteFile._id) },
    },
    {
      $lookup: {
        from: "teachers",
        localField: "byTeacher",
        foreignField: "_id",
        as: "teacherDetails",
      },
    },
    {
      $unwind: "$teacherDetails",
    },
    {
      $addFields: { teacherName: "$teacherDetails.fullName" },
    },
    {
      $project: {
        _id: 1,
        chapterNo: 1,
        teacherName: 1,
        standard: 1,
        subjectName: 1,
        notes: 1,
      },
    },
  ]);

  if(!noteData){
    throw new apiError(500,'noteFile is created and note data is unable to create')
  }

  return res
    .status(200)
    .json(new apiResponse(200, noteData[0], "notes uploaded."));
});

const getNotes = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.student._id)) {
    throw new apiError(401, "invalid user");
  }

  const findStudent = await students.findById(req.student._id);

  if (!findStudent) {
    throw new apiError(500, "user does not exist");
  }

  const noteData = await notes.aggregate([
    {
      $match: { standard : findStudent.standard },
    },
    {
      $lookup: {
        from: "teachers",
        localField: "byTeacher",
        foreignField: "_id",
        as: "teacherDetails",
      },
    },
    {
      $unwind: "$teacherDetails",
    },
    {
      $addFields: { teacherName: "$teacherDetails.fullName" },
    },
    {
      $project: {
        _id: 1,
        chapterNo: 1,
        teacherName: 1,
        standard: 1,
        subjectName: 1,
        notes: 1,
      },
    },
  ]);

  if(!noteData){
    throw new apiError(500,'note data is unable to retrive')
  }

  return res
    .status(200)
    .json(new apiResponse(200, noteData, "notes recieved."));


});

export { uploadNotes ,getNotes};
