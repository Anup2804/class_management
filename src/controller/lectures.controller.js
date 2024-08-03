import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teachers.model.js";
import { lectureNotices } from "../model/lecture.model.js";
import { students } from "../model/students.model.js";

const addLectureNotice = asyncHandler(async (req, res) => {
  //   const { teacherId } = req.params;
  const { standard, lectureName, time, description, date, board } = req.body;

  if (!standard && !lectureName && !time && !date && !board) {
    throw new apiError(
      402,
      "standard and lectureName and time and date and board is required."
    );
  }

  if (!mongoose.Types.ObjectId.isValid(req.teacher._id)) {
    throw new apiError(400, "teacher ID is incorrect");
  }

  const getTeacher = await teachers.findById(req.teacher._id);

  if (!getTeacher) {
    throw new apiError(402, "teacher with given id not found.");
  }

  if (!getTeacher.hiredForBoard.includes(board)) {
    throw new apiError(405, `can not upload lecture for ${board}`);
  }

  const lecture = await lectureNotices.create({
    byTeacher: req.teacher._id,
    standard,
    lectureName,
    time,
    description,
    date,
    board,
  });

  const getlecture = await lectureNotices.findById(lecture._id);

  if (!getlecture) {
    throw new apiError(500, "unable to create a lecture notice.");
  }

  // console.log(getlecture);

  const lectureData = await lectureNotices.aggregate([
    {
      $match: { _id: lecture._id },
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
        lectureName: 1,
        byTeacher: {
          _id: "$teacherDetails._id",
          name: "$teacherDetails.fullName",
        },
        time: 1,
        description: 1,
        date: 1,
        board: 1,
      },
    },
  ]);

  // console.log(lectureData)

  if (!lectureData.length) {
    throw new apiError(500, "lecture created but lectureData not created");
  }

  setTimeout(async () => {
    await lectureNotices.findByIdAndDelete(lecture._id);
  }, 20 * 60 * 60 * 1000);

  return res
    .status(200)
    .json(
      new apiResponse(
        200,
        lectureData,
        "lecture notice is created successfully"
      )
    );
});

const getLecture = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.student._id)) {
    throw new apiError(401, "invalid user");
  }

  const findStudent = await students.findById(req.student._id);

  if (!findStudent) {
    throw new apiError(402, "user does not exist");
  }

  const lectures = await lectureNotices.aggregate([
    {
      $match: {
        standard: findStudent.standard.toString(),
        board: findStudent.board.toString(),
      },
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
        lectureName: 1,
        byTeacher: {
          _id: "$teacherDetails._id",
          name: "$teacherDetails.fullName",
        },
        time: 1,
        description: 1,
        board: 1,
      },
    },
  ]);

  if (!lectures.length) {
    throw new apiError(500, "no lecture found");
  }

  return res.status(200).json(new apiResponse(200, lectures, "lecture found"));
});

const standardLecture = asyncHandler(async (req, res) => {
  const { standard, board } = req.body;
  if (!mongoose.Types.ObjectId.isValid(req.teacher._id)) {
    throw new apiError(400, "teacher ID is incorrect");
  }

  const getTeacher = await teachers.findById(req.teacher._id);

  if (!getTeacher) {
    throw new apiError(402, "teacher with given id not found.");
  }

  if (
    !getTeacher.hiredForStandard.includes(standard) &&
    !getTeacher.hiredForBoard.includes(board)
  ) {
    throw new apiError(402, "Cannot access the data");
  }

  const standardLec = await lectureNotices.find({
    standard: standard,
    board: board,
  });

  if (!standardLec) {
    throw new apiError(405, "not data found");
  }

  const standLec = await lectureNotices.aggregate([
    {
      $match: { standard: standard },
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
      $project: {
        _id: 1,
        standard: 1,
        lectureName: 1,
        byTeacher: {
          _id: "$teacherDetails._id",
          name: "$teacherDetails.fullName",
        },
        time: 1,
        date: 1,
        description: 1,
      },
    },
  ]);

  if (!standLec) {
    throw new apiError(405, "data does ot exist");
  }

  return res
    .status(200)
    .json(new apiResponse(200, standLec, "data got of standard lecture"));
});

export { addLectureNotice, getLecture, standardLecture };
