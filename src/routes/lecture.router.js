import {
  addLectureNotice,
  getLecture,
  standardLecture,
} from "../controller/lectures.controller.js";
import { Router } from "express";
import {
  verifyJwtStudent,
  verifyJwtTeacher,
} from "../middleware/auth.middleware.js";

const router = Router();

// the below is teacher api
router.route("/add-lecture").post(verifyJwtTeacher, addLectureNotice);
router.route("/standard-lecture").post(verifyJwtTeacher, standardLecture);

// the below is student api
router.route("/get-lecture").get(verifyJwtStudent, getLecture);

export default router;
