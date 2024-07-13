import { Router } from "express";
import { upload } from "../middleware/multer.middlewar.js";
import { verifyJwtTeacher } from "../middleware/auth.middleware.js";
import { uploadMarks } from "../controller/marks.controller.js";

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


export default router;
