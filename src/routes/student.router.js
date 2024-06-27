import { Router } from "express";
import {
  studentLogin,
  studentLogout,
  studentRegister,
} from "../controller/student.controller.js";
import { verifyJwtStudent } from "../middleware/auth.middleware.js";

const router = Router();

router.route("/register").post(studentRegister);
router.route("/login").post(studentLogin);
router.route("/logout").post(verifyJwtStudent, studentLogout);

export default router;
