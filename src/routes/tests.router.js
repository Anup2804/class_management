import { Router } from "express";
import { verifyJwtStudent, verifyJwtTeacher } from "../middleware/auth.middleware.js";
import { getTestNotice, uploadTestNotice } from "../controller/tests.controller.js";

const router = Router();

// the below route is for teacher
router.route("/add-test").post(verifyJwtTeacher, uploadTestNotice);

// the below route is for student
router.route("/get-testnotice").get(verifyJwtStudent,getTestNotice)

export default router;
