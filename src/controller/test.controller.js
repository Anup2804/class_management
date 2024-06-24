import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teacher.model.js";
import { testNotices } from "../model/test.model.js";

const uploadTestNotice = asyncHandler(async (req, res) => {
  const { subjectName, standard, chapterNo } = req.body;

  if (!subjectName && !standard && !chapterNo) {
    throw new apiError(
      402,
      "subjectName or chapterNo or standard is required."
    );
  }

  if (!req.teacher) {
    throw new apiError(403, "not authorized user");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, "you are not vaild teacher");
  }

  const test = await testNotices.create({
    byTeacher: req.teacher._id,
    subjectName,
    standard,
    chapterNo,
  });

  if (!test) {
    throw new apiError(402, "unable to create the test notice");
  }

  const testData = await testNotices.aggregate([
    {
      $match: { _id: test._id },
    },
    {
      $lookup: {
        from: "teachers",
        localField: "byTeacher",
        foreignField: "_id",
        as: "teacherDetails",
      },
    },
    { $unwind: "$teacherDetails" },
    {
      $addFields: {
        teacherName: "$teacherDetails",
      },
    },
    {
      $project: {
        _id: 1,
        standard: 1,
        subjectName:1,
        chapterNo:1,
        byTeacher: {
          _id: "$teacherDetails._id",
          name: "$teacherDetails.fullName",
        },
      },
    },
  ]);

  if (!testData) {
    throw new apiError(500, "testdata is not created.");
  }

  return res
    .status(200)
    .json(
      new apiResponse(200, testData[0], "test notice is created successfully")
    );
});


export {uploadTestNotice}
