import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teachers.model.js";
import { lectureNotices } from "../model/lecture.model.js";
import { students } from "../model/students.model.js";

const addLectureNotice = asyncHandler(async (req, res) => {
  const { standard, lectureName, time, description, date, board, TeacherName } =
    req.body;

  if (!standard && !lectureName && !time && !date && !board && !TeacherName) {
    throw new apiError(
      402,
      "standard and lectureName and time and date and board is required."
    );
  }

  if (!["SSC", "CBSE", "ICSE"].includes(board.toString().toUpperCase())) {
    throw new apiError(402, "invaild board input.");
  }

  if (!mongoose.Types.ObjectId.isValid(req.admin._id)) {
    throw new apiError(400, "admin ID is incorrect");
  }

  console.log(req.admin);

  const getTeacher = await teachers.findOne({
    fullName: TeacherName,
    adminName: req.admin.adminName,
  });

  if (!getTeacher) {
    throw new apiError(402, "teacher with given id not found.");
  }

  if (!getTeacher.hiredForBoard.includes(board.toUpperCase())) {
    throw new apiError(405, `can not upload lecture for ${board}`);
  }

  const lecture = await lectureNotices.create({
    byTeacher: getTeacher._id,
    standard,
    lectureName,
    time,
    description,
    date,
    board,
    adminName: req.admin.adminName,
  });

  const getlecture = await lectureNotices.findById(lecture._id);

  if (!getlecture) {
    throw new apiError(500, "unable to create a lecture notice.");
  }

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
        adminName: 1,
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

const studentLecture = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.student._id)) {
    throw new apiError(401, "invalid user");
  }

  const findStudent = await students.findById(req.student._id);

  if (!findStudent) {
    throw new apiError(402, "user does not exist");
  }

  // console.log(findStudent);

  const lectures = await lectureNotices.aggregate([
    {
      $match: {
        board: findStudent.board.toString(),
        adminName: findStudent.adminName.toString(),
        standard: findStudent.standard.toString(),
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
        adminName: 1,
      },
    },
  ]);

  if (!lectures.length) {
    throw new apiError(500, "no lecture found");
  }

  return res.status(200).json(new apiResponse(200, lectures, "lecture found"));
});

const teacherLecture = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.teacher._id)) {
    throw new apiError(401, "invalid user");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, "user does not exist");
  }


  // console.log(findStudent);

  const lectures = await lectureNotices.aggregate([
    {
      $match: {
        adminName: findTeacher.adminName.toString(),
        board: { $in: findTeacher.hiredForBoard.map(board => board.toUpperCase()) }
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
        adminName: 1,
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

export { addLectureNotice, studentLecture, standardLecture, teacherLecture };
