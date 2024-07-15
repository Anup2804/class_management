import { Router } from "express";
import { upload } from "../middleware/multer.middlewar.js";
import { verifyJwtStudent, verifyJwtTeacher } from "../middleware/auth.middleware.js";
import { getMarks, uploadMarks } from "../controller/marks.controller.js";

const router = Router();

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

router.route("/get-marks").get(verifyJwtStudent,getMarks)


export default router;
