import { Router } from "express";
import { renderstudent } from "../controllers/student.controller.js";

const router = Router();
router.get("/students",renderstudent);

export default router