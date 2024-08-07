import { Router } from "express";
import { upload } from "../middleware/multer.middlewar.js";
import {
  verifyJwtAdmin,
  verifyJwtStudent,
  verifyJwtTeacher,
} from "../middleware/auth.middleware.js";
import {
  delMarks,
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
      maxCount: 20,
    },
  ]),
  verifyJwtTeacher,
  uploadMarks
);

// this api is for student

router.route("/get-marks").get(verifyJwtStudent, getMarks);

// this api is for admin

router.route("/marksDetail").get(verifyJwtAdmin, getAllMarks);
router.route("/del/:MarksId").post(verifyJwtAdmin,delMarks
)

export default router;
