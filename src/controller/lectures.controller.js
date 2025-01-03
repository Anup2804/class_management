import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teachers.model.js";
import { lectures } from "../model/lecture.model.js";
import { students } from "../model/students.model.js";
import { formatDateToLocalISO } from "../utils/function/date.js";

const addLectureNotice = asyncHandler(async (req, res) => {
  const { standard, lectureName, startTime,endTime, description, board, teacherName, date } =
    req.body;

  if (!standard && !lectureName && !startTime && !endTime && !board && !teacherName && !date) {
    throw new apiError(
      402,
      "standard and lectureName and start and end time and date and board is required."
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
    fullName: teacherName,
    adminEmail: req.admin.email,
  });

  if (!getTeacher) {
    throw new apiError(402, "teacher with given name not found.");
  }

  if (!getTeacher.hiredForBoard.includes(board.toUpperCase())) {
    throw new apiError(405, `can not upload lecture for ${board}`);
  }

  const formattedDate = (() => {
    const [day, month, year] = date.split("/");
    return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
  })();

  const lecture = await lectures.create({
    byTeacher: getTeacher._id,
    standard,
    lectureName,
    startTime,
    endTime,
    description,
    date: formattedDate,
    board: board.trim().toUpperCase(),
    adminEmail: req.admin.email,
  });

  const getlecture = await lectures.findById(lecture._id);

  if (!getlecture) {
    throw new apiError(500, "unable to create a lecture notice.");
  }

  const lectureData = await lectures.aggregate([
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
        startTime:1,
        endTime:1,
        description: 1,
        date: 1,
        board: 1,
        adminEmail: 1,
      },
    },
  ]);

  // console.log(lectureData)

  if (!lectureData.length) {
    throw new apiError(500, "lecture created but lectureData not created");
  }

  // setTimeout(async () => {
  //   await lectures.findByIdAndDelete(lecture._id);
  // }, 20 * 60 * 60 * 1000);

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

  const today = new Date();
  const realDate = new Date(today);
  const tomorrow = new Date(today);

  realDate.setDate(today.getDate());
  tomorrow.setDate(today.getDate() + 1);

  const todayStr = formatDateToLocalISO(realDate).toString();
  const tomorrowStr = formatDateToLocalISO(tomorrow).toString();

  console.log(todayStr);
  console.log(tomorrowStr);

  const lecture = await lectures.aggregate([
    {
      $match: {
        board: findStudent.board.toString(),
        adminEmail: findStudent.adminEmail.toString(),
        standard: findStudent.standard.toString(),
        date: { $in: [todayStr, tomorrowStr] },
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
        startTime:1,
        endTime:1,
        description: 1,
        board: 1,
        date: 1,
      },
    },
  ]);

  if (!lecture.length) {
    throw new apiError(500, "no lecture found");
  }

  return res.status(200).json(new apiResponse(200, lecture, "lecture found"));
});

const teacherLecture = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.teacher._id)) {
    throw new apiError(401, "invalid user");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, "user does not exist");
  }

  const today = new Date();
  const realDate = new Date(today);
  const tomorrow = new Date(today);

  realDate.setDate(today.getDate());
  tomorrow.setDate(today.getDate() + 1);

  const todayStr = formatDateToLocalISO(realDate).toString();
  const tomorrowStr = formatDateToLocalISO(tomorrow).toString();

  const lecture = await lectures.aggregate([
    {
      $match: {
        adminEmail: findTeacher.adminEmail,
        board: {
          $in: findTeacher.hiredForBoard.map((board) => board.toUpperCase()),
        },
        byTeacher: findTeacher._id,
        date: { $in: [todayStr, tomorrowStr] },
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
        startTime:1,
        endTime:1,
        description: 1,
        board: 1,
        adminName: 1,
        date:1
      },
    },
  ]);

  if (!lecture.length) {
    throw new apiError(500, "no lecture found");
  }

  return res.status(200).json(new apiResponse(200, lecture, "lecture found"));
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

  const standardLec = await lectures.find({
    standard: standard,
    board: board,
  });

  if (!standardLec) {
    throw new apiError(405, "not data found");
  }

  const standLec = await lectures.aggregate([
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
        startTime:1,
        endTime:1,
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

const updateLecture = asyncHandler(async (req, res) => {
  const { lectureId } = req.params;
  const { standard, startTime,endTime } = req.body;

  if (!standard && !startTime && !endTime && !lectureId) {
    throw new apiError(402, "all input are required.");
  }

  const getlecture = await lectures.findOne({
    _id: new mongoose.Types.ObjectId(lectureId),
    adminEmail: req.admin.email.toString(),
  });

  if (!getlecture) {
    throw new apiError(402, "no lecture found");
  }

  const update = await lectures.findByIdAndUpdate(
    lectureId,
    {
      standard: standard,
      startTime:startTime,
      endTime:endTime,

      
    },
    { new: true }
  );

  if (!update) {
    throw new apiError(402, "unable to update.");
  }

  return res.status(200).json(new apiResponse(200, update, "lecture update"));
});

const deleteLecture = asyncHandler(async (req, res) => {
  const { lectureId } = req.params;

  if (!req.admin) {
    throw new apiError(402, "invalid accesstoken");
  }

  // console.log(new Date().toISOString().split('T')[0] )

  const getLecture = await lectures.findOne({
    _id: lectureId,
    adminEmail: req.admin.email,
  });

  if (!getLecture) {
    throw new apiError(405, "no lecture found for deletion");
  }

  const deleteLecture = await lectures.findByIdAndDelete(lectureId);

  if (!deleteLecture) {
    throw new apiError(405, "unable to delete data");
  }

  return res.status(200).json(new apiResponse(200, "lecture deleted."));
});

const todayLecture = asyncHandler(async (req, res) => {
  if (!req.admin) {
    throw new apiError(402, "invalid token");
  }

  const today = new Date();

  const realDate = new Date(today);
  realDate.setDate(today.getDate());
  const todayStr = formatDateToLocalISO(realDate).toString();

  const findlecture = await lectures.find({
    date: todayStr,
    adminEmail: req.admin.email,
  });

  if (!findlecture) {
    throw new apiError(402, "no data found");
  }

  return res.status(200).json(new apiResponse(200, findlecture, "data found"));
});

export {
  addLectureNotice,
  studentLecture,
  standardLecture,
  teacherLecture,
  updateLecture,
  deleteLecture,
  todayLecture,
};
