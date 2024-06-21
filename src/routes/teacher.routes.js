import { Router } from "express";
import { teacherLogin, teacherRegister } from "../controller/teacher.controller.js";

const router = Router();

router.route("/register").post(teacherRegister);
router.route("/login").post(teacherLogin)

export default router;
