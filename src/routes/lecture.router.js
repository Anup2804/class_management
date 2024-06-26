import {
  addLectureNotice,
  getLecture,
} from "../controller/lecture.controller.js";
import { Router } from "express";
import {
  verifyJwtStudent,
  verifyJwtTeacher,
} from "../middleware/auth.middleware.js";

const router = Router();

// the below is teacher api
router.route("/add-lecture").post(verifyJwtTeacher, addLectureNotice);

// the below is student api
router.route("/get-lecture").get(verifyJwtStudent, getLecture);

export default router;
