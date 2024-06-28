import { Router } from "express";
import { upload } from "../middleware/multer.middlewar.js";
import {
  verifyJwtStudent,
  verifyJwtTeacher,
} from "../middleware/auth.middleware.js";
import { getNotes, uploadNotes } from "../controller/notes.controller.js";

const router = Router();

router.route("/add-note").post(
  upload.fields([
    {
      name: "notes",
      maxCount: 1,
    },
  ]),
  verifyJwtTeacher,
  uploadNotes
);

router.route("/get-notes").get(verifyJwtStudent, getNotes);

export default router;
