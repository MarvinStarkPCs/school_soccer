import {Router} from "express";

import { getTestconnection } from "../controllers/index.controller.js";

const router = Router();

router.get("/", getTestconnection)


export default router