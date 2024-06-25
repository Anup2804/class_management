import { Router } from "express";
import { upload } from "../middleware/multer.middlewar.js";
import { verifyJwtTeacher } from "../middleware/auth.middleware.js";
import { uploadNotes } from "../controller/notes.controller.js";

const router = Router();

router.route("/add-note").post(
  verifyJwtTeacher,
  upload.fields([
    {
      name: "notes",
      maxCount: 1,
    },
  ]),
  uploadNotes
);

export default router;
