import { Router } from "express";
import {
  verifyJwtAdmin,
  verifyJwtStudent,
  verifyJwtTeacher,
} from "../middleware/auth.middleware.js";
import {
  getAllTest,
  getTestNotice,
  todayTest,
  uploadTestNotice,
} from "../controller/tests.controller.js";

const router = Router();

// the below route is for teacher
router.route("/add-test").post(verifyJwtTeacher, uploadTestNotice);

// the below route is for student
router.route("/get-testnotice").get(verifyJwtStudent, getTestNotice);

// the below route is admin
router.route("/all-test").post(verifyJwtAdmin, getAllTest);
router.route("/today-test").post(verifyJwtAdmin, todayTest);

export default router;
