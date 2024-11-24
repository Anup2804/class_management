import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { uploadoncloudnary } from "../utils/cloudnary/cloudnary.js";
import { apiResponse } from "../utils/apiResponse.js";
import { marks } from "../model/marks.model.js";
import { teachers } from "../model/teachers.model.js";
import { students } from "../model/students.model.js";

const uploadMarks = asyncHandler(async (req, res) => {
  const { subjectName, chapterNo, standard, description, board } = req.body;

  if (!chapterNo && !standard && !subjectName && !board) {
    throw new apiError(402, "subjetName or standard or chapterNo is required ");
  }

  if (!req.teacher) {
    throw new apiError(401, "user not logged in or invalid user.");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, " user not found.");
  }

  if (
    !findTeacher.hiredForStandard.includes(standard) &&
    !findTeacher.hiredForBoard.includes(board)
  ) {
    throw new apiError(405, `can not upload for ${standard} of ${board}`);
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
  // console.log(uploadFile);

  const mark = await marks.create({
    byTeacher: req.teacher._id,
    subjectName,
    chapterNo,
    file: uploadFile.url,
    standard,
    description,
    board:board.toUpperCase(),
    adminEmail: req.teacher.adminEmail,
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
        description: 1,
        board: 1,
        adminName: 1,
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

const getMarks = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.student._id)) {
    throw new apiError(401, "invalid user");
  }

  const studentData = await students.findById(req.student._id);

  if (!studentData) {
    throw new apiError(402, "student with id not found");
  }

  const markData = await marks.find({
    standard: req.student.standard,
    board: req.student.board,
  });
  console.log(markData);
  // console.log(req.student.board);
  // console.log(req.student.standard);

  const getMark = await marks.aggregate([
    {
      $match: {
        adminName: req.student.adminName,
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
        subjectName: 1,
        byTeacher: {
          _id: "$teacherDetails._id",
          name: "$teacherDetails.fullName",
        },
        chapterNo: 1,
        file: 1,
        description: 1,
        board: 1,
        adminEmail: 1,
      },
    },
  ]);

  if (!getMark.length) {
    throw new apiError(405, "marks is empty");
  }

  return res.status(200).json(new apiResponse(200, getMark, "marks fetched "));
});

const delMarks = asyncHandler(async(req,res)=>{
  const {MarksId} = req.params;

  if(!req.admin){
    throw new apiError(402,'invalid token')
  }

  const findMarks = await marks.findOneAndDelete(
    {_id:MarksId,
      adminEmail:req.admin.email.toString()
    });

  if(!findMarks){
    throw new apiError(500,'no data found')
  }

  return res.status(200).json(new apiResponse(200,'data deleted.'))

  
})

const getAllMarks = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.admin._id)) {
    throw new apiError(402, "invalid id");
  }
  const getmarks = await marks.find({ adminEmail: req.admin.email.toString() });

  if (!getmarks) {
    throw new apiError(402, "not data found.");
  }

  return res.status(200).json(new apiResponse(200, getmarks, "data found."));
});

export { uploadMarks, getMarks,getAllMarks,delMarks };
