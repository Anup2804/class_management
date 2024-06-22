import { addLectureNotice } from "../controller/lecture.controller.js";
import { Router } from "express";
import { verifyJwtTeacher } from "../middleware/auth.middleware.js";

const router = Router();

router.route("/add-lecture/:teacherId").post(verifyJwtTeacher, addLectureNotice);

export default router;
