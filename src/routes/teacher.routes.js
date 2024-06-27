import { Router } from "express";
import {
  teacherLogin,
  teacherLogout,
  teacherRegister,
} from "../controller/teacher.controller.js";
import { verifyJwtTeacher } from "../middleware/auth.middleware.js";

const router = Router();

router.route("/register").post(teacherRegister);
router.route("/login").post(teacherLogin);
router.route("/logout").post(verifyJwtTeacher, teacherLogout);

export default router;
