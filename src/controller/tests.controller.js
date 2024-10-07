import mongoose from "mongoose";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teachers.model.js";
import { testNotices } from "../model/tests.model.js";
import { students } from "../model/students.model.js";
import { formatDateToLocalISO } from "../utils/function/date.js";

const uploadTestNotice = asyncHandler(async (req, res) => {
  const { subjectName, standard, chapterNo, time, description, board, date } =
    req.body;

  if (!subjectName && !standard && !chapterNo && !time && !board && !date) {
    throw new apiError(
      402,
      "subjectName or chapterNo or standard or time is required."
    );
  }

  if (!req.teacher) {
    throw new apiError(403, "not authorized user");
  }

  const findTeacher = await teachers.findById(req.teacher._id);

  if (!findTeacher) {
    throw new apiError(402, "you are not vaild teacher");
  }

  const convertDate = (date) => {
    const [day, month, year] = date.split('/');
    return `${year}-${month}-${day}`;
  };


  const test = await testNotices.create({
    byTeacher: req.teacher._id,
    adminEmail: req.teacher.adminEmail,
    subjectName,
    standard,
    chapterNo,
    time,
    description,
    board,
    date:convertDate(date),
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
        teacherName: "$teacherDetails.fullName",
      },
    },
    {
      $project: {
        _id: 1,
        standard: 1,
        subjectName: 1,
        chapterNo: 1,
        byTeacher: {
          _id: "$teacherDetails._id",
          name: "$teacherDetails.fullName",
        },
        time: 1,
        description: 1,
        board: 1,
        adminEmail: 1,
        date: 1,
      },
    },
  ]);

  if (!testData) {
    throw new apiError(500, "testdata is not created.");
  }

  // setTimeout(async () => {
  //   await lectureNotices.findByIdAndDelete(lecture._id);
  // }, 168 * 60 * 60 * 1000);

  return res
    .status(200)
    .json(
      new apiResponse(200, testData[0], "test notice is created successfully")
    );
});

const getTestNotice = asyncHandler(async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.student._id)) {
    throw new apiError(401, "invalid user");
  }

  const findStudent = await students.findById(req.student._id);

  if (!findStudent) {
    throw new apiError(402, "user does not exist");
  }

  const today = new Date();

  const realDate = new Date(today);
  realDate.setDate(today.getDate());
  const todayStr = formatDateToLocalISO(realDate).toString();

  console.log(todayStr);

  const test = await testNotices.aggregate([
    {
      $match: {
        standard: findStudent.standard,
        board: findStudent.board,
        adminEmail: findStudent.adminEmail,
        date: { $gte: todayStr }
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
        time: 1,
        description: 1,
        board: 1,
        adminEmail: 1,
        date:1,
      },
    },
  ]);

  if (!test.length) {
    throw new apiError(500, "no Test found");
  }

  return res.status(200).json(new apiResponse(200, test, "test found"));
});

const getAllTest = asyncHandler(async(req,res)=>{
  if(!req.admin){
    throw new apiError(402,'invalid token')
  }

  const getAll = await testNotices.find({
    adminEmail:req.admin.email
  })

  if(!getAll){
    throw new apiError(402,'no data found')
  }

  return res.status(200).json(new apiResponse(200,getAll,'data found'))
})

const todayTest = asyncHandler(async(req,res)=>{
  if(!req.admin){
    throw new apiError(402,'invalid admin')
  }

  const today = new Date();

  const realDate = new Date(today);
  realDate.setDate(today.getDate());
  const todayStr = formatDateToLocalISO(realDate).toString();

  console.log(today);

  const todayTest = await testNotices.find({
    date:todayStr,
    adminEmail:req.admin.email
  })

  if(!todayTest){
    return new apiError(402,'data not found for today test.')
  }

  return res.status(200).json(new apiResponse(200,todayTest,'data found'))
})

export { uploadTestNotice, getTestNotice,getAllTest ,todayTest};
