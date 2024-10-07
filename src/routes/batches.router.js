import { Router } from "express";
import { AddBatches } from "../controller/batches.controller.js";
import { verifyJwtTeacher } from "../middleware/auth.middleware.js";

const router = Router();


router.route("/batch/:lectureId").post(verifyJwtTeacher,AddBatches);


export default router;