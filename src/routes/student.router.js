import { Router } from "express";
import { studentLogin, studentRegister } from "../controller/student.controller.js";

const router = Router();

router.route("/register").post(studentRegister);
router.route("/login").post(studentLogin)

export default router;
