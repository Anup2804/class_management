import { Router } from "express";
import { verifyJwtTeacher } from "../middleware/auth.middleware.js";
import { uploadTestNotice } from "../controller/test.controller.js";

const router = Router();

router.route("/add-test").post(verifyJwtTeacher, uploadTestNotice);

export default router;
