import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { uploadoncloudnary } from "../utils/cloudnary/cloudnary.js";
import { apiResponse } from "../utils/apiResponse.js";
import { marks } from "../model/marks.model.js";
import { teachers } from "../model/teacher.model.js";

const uploadMarks = asyncHandler(async (req, res) => {
  const { subjectName, chapterNo, standard ,description} = req.body;

  if (!req.teacher && !mongoose.Types.ObjectId.isValid(!req.teacher._id)) {
    throw new apiError(401, "user not logged in or invalid user.");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, " user not found.");
  }

  if (!chapterNo && !standard && !subjectName) {
    throw new apiError(402, "subjetName or standard or chapterNo is required ");
  }

  const filePath = req.files?.file[0]?.path;
  console.log(filePath);

  if (!filePath) {
    throw new apiError(401, "marks file is required.");
  }

  const uploadFile = await uploadoncloudnary(filePath);
  console.log(uploadFile);
  if (!uploadFile) {
    throw new apiError(405, "file is missing");
  }
  console.log(uploadFile);

  const mark = await marks.create({
    byTeacher: req.teacher._id,
    subjectName,
    chapterNo,
    file: uploadFile.url,
    standard,
    description
  });

  if (!mark) {
    throw new apiError(500, "unable to create marks data");
  }

  const marksData = await marks.aggregate([
    {
      $match: { _id: new mongoose.Types.ObjectId(mark._id) },
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
        file: 1,
        description:1
      },
    },
  ]);

  if (!marksData) {
    throw new apiError(500, "sorry for the inconvience");
  }

  return res
    .status(200)
    .json(new apiResponse(200, marksData[0], "marks uploaded."));
});

export { uploadMarks };
