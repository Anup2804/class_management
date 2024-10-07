import { Router } from "express";
import { addTimeTable } from "../controller/timeTable.controller.js";
import { verifyJwtAdmin } from "../middleware/auth.middleware.js";


const router = Router();


router.route("/add-timetable").post(verifyJwtAdmin,addTimeTable);


export default router;
