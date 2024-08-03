import { Router } from "express";
import { upload } from "../middleware/multer.middlewar.js";
import {
  verifyJwtAdmin,
  verifyJwtStudent,
  verifyJwtTeacher,
} from "../middleware/auth.middleware.js";
import {
  getAllMarks,
  getMarks,
  uploadMarks,
} from "../controller/marks.controller.js";

const router = Router();

// this api is for teacher.

router.route("/upload-marks").post(
  upload.fields([
    {
      name: "file",
      maxCount: 1,
    },
  ]),
  verifyJwtTeacher,
  uploadMarks
);

// this api is for student

router.route("/get-marks").get(verifyJwtStudent, getMarks);

// this api is for admin

router.route("/marksDetail").get(verifyJwtAdmin, getAllMarks);

export default router;
