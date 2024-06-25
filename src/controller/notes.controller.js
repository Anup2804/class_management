import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teacher.model.js";
import { uploadoncloudnary } from "../utils/cloudnary/cloudnary.js";
import { notes } from "../model/notes.model.js";

const uploadNotes = asyncHandler(async (req, res) => {
  const { subjectName, chapterNo,standard} = req.body;

  if (!req.teacher && !mongoose.Types.ObjectId.isValid(!req.teacher._id)) {
    throw new apiError(401, "user not logged in or invalid user.");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, " user not found.");
  }

  if (!subjectName && !chapterNo && !standard) {
    throw new apiError(402, "subjectname and chapterNo and standard  is required");
  }

  const notePath = req.files?.notes[0].path;

  const notesUrl = await uploadoncloudnary(notePath);

  if (!notesUrl) {
    throw new apiError(402, "note path is required.");
  }

  const noteFile = await notes.create({
    byTeacher: req.teacher._id,
    subjectName,
    chapterNo,
    notes: notesUrl.url,
    standard
  });

  return res.status(200).json(new apiResponse(200, noteFile, "notes uploaded."));
});

export { uploadNotes };
