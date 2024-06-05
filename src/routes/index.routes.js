import {Router} from "express";

import { getTestconnection, renderIndex } from "../controllers/index.controller.js";

const router = Router();

router.get("/ping", getTestconnection)

router.get("/", renderIndex)


export default router