import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teacher.model.js";
import { lectureNotices } from "../model/lecture.model.js";

const addLectureNotice = asyncHandler(async (req, res) => {
  const { teacherId } = req.params;
  const { standard, lectureName } = req.body;

  if (!mongoose.Types.ObjectId.isValid(teacherId)) {
    throw new apiError(400, "teacher ID is incorrect");
  }

  const getTeacher = await teachers.findById(teacherId);

  if (!getTeacher) {
    throw new apiError(402, "teacher with given id not found.");
  }

  if (!standard && !lectureName) {
    throw new apiError(402, "standard and lectureName is required.");
  }

  const lecture = await lectureNotices.create({
    byTeacher: teacherId,
    standard,
    lectureName,
  });

  const getlecture = await lectureNotices.findById(lecture._id);

  if (!getlecture) {
    throw new apiError(500, "unable to create a lecture notice.");
  }

  console.log(getlecture);

  const lectureData = await lectureNotices.aggregate([
    {
      $match: { _id: new mongoose.Types.ObjectId(lecture._id) },
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
      $project: {
        _id: 1,
        standard: 1,
        lectureName: 1,
        byTeacher: {
          _id: "$teacherDetails._id",
          name: "$teacherDetails.fullName",
        },
      },
    },
  ]);

  //   console.log(lectureData)

  //   if(!lectureData.length){
  //     throw new apiError(500,'lecture created but lectureData not created')
  //   }

  return res
    .status(200)
    .json(
      new apiResponse(
        200,
        lectureData[0],
        "lecture notice is created successfully"
      )
    );
});

export { addLectureNotice };
