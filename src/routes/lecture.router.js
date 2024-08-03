import {
  addLectureNotice,
  standardLecture,
  studentLecture,
  teacherLecture,
} from "../controller/lectures.controller.js";
import { Router } from "express";
import {
  verifyJwtAdmin,
  verifyJwtStudent,
  // verifyJwtStudent,
  verifyJwtTeacher,
} from "../middleware/auth.middleware.js";

const router = Router();

// the below is teacher api
// router.route("/standard-lecture").post(verifyJwtTeacher, standardLecture);
router.route("/getLecture").get(verifyJwtTeacher, teacherLecture);

// the below is student api
router.route("/get-lecture").get(verifyJwtStudent, studentLecture);

// the below is admin api
router.route("/add-lecture").post(verifyJwtAdmin, addLectureNotice);

export default router;
