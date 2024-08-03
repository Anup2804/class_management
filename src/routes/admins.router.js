import { Router } from "express";
import { adminLogin, adminLogout, adminRegister } from "../controller/admins.controller.js";
import { verifyJwtAdmin } from "../middleware/auth.middleware.js";

const router = Router();


router.route("/register").post(adminRegister);

router.route("/login").post(adminLogin);

router.route("/logout").post(verifyJwtAdmin,adminLogout)


export default router;