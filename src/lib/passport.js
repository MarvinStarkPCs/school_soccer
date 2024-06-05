import passport from "passport";
import { Strategy as LocalStrategy } from "passport-local";

import { pool } from "../database.js";
import { matchPassword } from "./helpers.js";

passport.use(
  "local.signin",
  new LocalStrategy(
    {
    usernameField: 'username',
    passwordField: 'password',
      passReqToCallback: true,
    },
    async (req, usernameField, passwordField, done) => {
      console.log(usernameField)
      console.log(passwordField)
      const [rows] = await pool.query("SELECT * FROM users WHERE username = ?", [
        usernameField,
      ]);

      if (!rows.length) return done(null, false, req.flash("error", "Usuario no Existe") );

      const user = rows[0];
      const validPassword = await matchPassword(passwordField, user.password);

      if (!validPassword) {
        console.log("hola contarseña incorecta")
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
