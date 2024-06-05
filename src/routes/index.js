import { Router } from "express";
// import auth from "./auth.routes.js";
import index from "./index.routes.js";
import auth from "./auth.routes.js"
import student from "./students.routes.js"
const router = Router();

router.use(index);
router.use(auth)
router.use("/students",student)
export default router;
 