import passport from "passport";
import { encryptPassword } from "../lib/helpers.js";
import { pool } from "../database.js";


export const signUp = async (req, res, next) => {
  const { fullname, trade, email, password1 } = req.body;

console.log(fullname+" "+email+" "+password1)

  const password = await encryptPassword(password1);
const rol = "admin"
  // Saving in the Database
  const [result] = await pool.query("INSERT INTO users SET ? ", {
    fullname,
    rol,
    trade,
    email,
    password,
  });

  req.login(
    {
      id: result.insertId,
      fullname,
      email,
    },
    (err) => {
      if (err) {
        return next(err);
      }
      return res.redirect("/students");
    }
  );
};

///// registro de usuarios
export const renderSignIn = (req, res) => res.render("auth/signin");

export const signIn = passport.authenticate("local.signin", {
  successRedirect: "/students",
  failureRedirect: "/signin",
  failureMessage: true,
  failureFlash: true,
});



export const logout = (req, res, next) => {
  req.logout(function (err) {
    if (err) return next(err);
    res.redirect("/");
  });
};

 