import { Router } from "express";
import { studentRegister } from "../controller/student.controller.js";

const router = Router();

router.route("/register").post(studentRegister);

export default router;
