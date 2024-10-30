import cron from "node-cron";
import { Timetable } from "../model/timetable.model.js";
import { apiError } from "../utils/apiError.js";
import { teachers } from "../model/teachers.model.js";
import { apiResponse } from "../utils/apiResponse.js";
import { asyncHandler } from "../utils/asyncHandler.js";
import { lectures } from "../model/lecture.model.js";
import { formatDateToLocalISO } from "../utils/function/date.js";

const addTimeTable = asyncHandler(async (req, res) => {
  // take the data like date,standard, borad,adminEmail.
  // verify the data
  // map the name of the byteacher field and add name of hte teacher.
  // create the entry in the database
  // save it
  // end

  const { standard, board, days } = req.body;

  if (!standard && !board && !days) {
    throw new apiError(402, "All fields are required.");
  }

  if (!req.admin.email) {
    throw new apiError(405, "invalid admin user.");
  }

  const adminEmail = req.admin.email;

  const existingTimetable = await Timetable.findOne({
    standard,
    board,
    adminEmail,
  });

  if (existingTimetable) {
    throw new apiError(
      405,
      "A timetable for this standard, board, and adminEmail already exists."
    );
  }

  for (let i = 0; i < days.length; i++) {
    const day = days[i];

    for (let j = 0; j < day.lectures.length; j++) {
      const lecture = day.lectures[j];

      // console.log(lecture);

      const teacher = await teachers.findOne({
        fullName: lecture.teacherName, 
        adminEmail: adminEmail, 
      });

      // console.log(teacher);

      if (!teacher) {
        throw new apiError(404, `Teacher ${lecture.teachetName} not found.`);
      }

      
      lecture.byTeacher = teacher._id;
    }
  }
  


  const timetable = await Timetable.create({
    standard,
    adminEmail,
    board,
    days,
  });

  if (!timetable) {
    throw new apiError(500, "unable to create timetable.");
  }

  const timetables = await Timetable.aggregate([
    { $match: { _id: timetable._id } },
    { $unwind: "$days" },
    { $unwind: "$days.lectures" },
    {
      $lookup: {
        from: "teachers",
        let: {
          teacherId: "$days.lectures.byTeacher",
          adminEmail: "$adminEmail",
        },
        pipeline: [
          {
            $match: {
              $expr: {
                $and: [
                  { $eq: ["$_id", "$$teacherId"] },
                  { $eq: ["$adminEmail", "$$adminEmail"] },
                ],
              },
            },
          },
        ],
        as: "teacherInfo",
      },
    },

    {
      $addFields: {
        teacherName: {
          $ifNull: [
            { $arrayElemAt: ["$teacherInfo.fullName", 0] },
            "Not Assigned",
          ],
        },
        teacherId: {
          $ifNull: [{ $arrayElemAt: ["$teacherInfo._id", 0] }, "Not Assigned"],
        },
      },
    },
    {
      $group: {
        _id: "$days._id",
        day: { $first: "$days.day" },
        lectures: {
          $push: {
            lectureName: "$days.lectures.lectureName",
            time: "$days.lectures.time",
            description: "$days.lectures.description",
            teacherName: "$teacherName",
            byTeacher: "$teacherId",
          },
        },
      },
    },
    {
      $project: {
        adminEmail: 1,
        standard: 1,
        board: 1,
        _id: 1,
        day: 1,
        lectures: 1,
      },
    },
  ]);

  return res
    .status(200)
    .json(new apiResponse(200, timetables, "timetable prepared."));
});

const getTodayDay = () => {
  const today = new Date();
  const options = { weekday: "long" };
//   console.log(options);
  return today.toLocaleDateString("en-US", options);
};

const schedulingLectureForToday = async () => {
  const todayDay = getTodayDay();

  const timetable = await Timetable.findOne({
    "days.day": todayDay,
  });

  if (!timetable) {
    console.log(`No timetable found for today (${todayDay})`);
    return;
  }

  const todayLectures = timetable.days.find((d) => d.day === todayDay).lectures;

  const today = new Date();
  const realDate = new Date(today);
  realDate.setDate(today.getDate());
  const todayStr = formatDateToLocalISO(realDate).toString();

  todayLectures.forEach(async (lecture) => {
     console.log(lecture.byTeacher);
    const newLecture = await lectures.create({
      byTeacher: lecture.byTeacher,
      lectureName: lecture.lectureName,
      standard: timetable.standard,
      date: todayStr,
      time: lecture.time,
      description: lecture.description || "",
      board: timetable.board,
      adminEmail: timetable.adminEmail,
    });

    console.log(`Lecture scheduled: ${newLecture.lectureName} for ${todayDay}`);
  });
}

export { addTimeTable, schedulingLectureForToday };
