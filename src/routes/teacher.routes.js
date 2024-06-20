import { Router } from "express";
import { teacherRegister } from "../controller/teacher.controller.js";

const router = Router();

router.route("/register").post(teacherRegister);

export default router;
