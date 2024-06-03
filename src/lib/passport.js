import passport from "passport";
import { Strategy as LocalStrategy } from "passport-local";

import { pool } from "../database.js";
import { matchPassword } from "./helpers.js";

passport.use(
  "local.signin",
  new LocalStrategy(
    {
      usernameField: "email_signin",
      passwordField: "password_signin",
      passReqToCallback: true,
    },
    async (req, email_signin, password_signin, done) => {
      const [rows] = await pool.query("SELECT * FROM users WHERE email = ?", [
        email_signin,
      ]);

      if (!rows.length)
        return done(null, false, req.flash("error", "Usuario no Existe"));

      const user = rows[0];
      const validPassword = await matchPassword(password_signin, user.password);

      if (!validPassword) {
        req.flash("error", "Contraseña incorrecta");
        return done(null, false);
      }

      done(null, user);
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  const [rows] = await pool.query("SELECT * FROM users WHERE id = ?", [id]);
  done(null, rows[0]);
});
