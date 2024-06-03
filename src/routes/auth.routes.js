import { Router } from "express";
import { isNotLoggedIn } from "../middlewares/protectedRoutes.js";
import { validator } from "../middlewares/validator.middleware.js";

import {
  renderSignIn,
  signUp,
  signIn,
  logout
} from "../controllers/auth.controller.js";
// import { validator } from "../middlewares/validator.middleware.js";
import {
  signinSchema,
  signupSchema,
  
} from "../schemas/auth.schema.js";

const router = Router();
// funciones get
router.get("/signin", renderSignIn);
router.post("/signin", validator(signinSchema), signIn);
router.post("/signup", validator(signupSchema), signUp);


router.get("/logout",logout);





// router.get("/reset-password/:token",renderResetPassword);
// router.post("/reset-password/:token", resetPassword)
export default router;
