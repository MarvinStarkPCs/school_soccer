import { Router } from "express";
import { renderstudent,renderStudentsList, uploadImg} from "../controllers/student.controller.js";
import upload from "../middlewares/multerConfig.js";
const router = Router();

router.post("/uploadimg",upload.single('image'), uploadImg)
router.get("/",renderStudentsList);
router.get("/uploadimg",renderStudentsList);



export default router