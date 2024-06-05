import express from "express";
import morgan from "morgan";
import path from "path";
import { create } from "express-handlebars";
import session from "express-session";
import passport from "passport";
import cookieParser from "cookie-parser";
import flash from "connect-flash";
import expressMySQLSession from "express-mysql-session";
import { fileURLToPath } from "url";
import routes from "./routes/index.js";
import "./lib/passport.js";
import * as helpers from "./lib/handlebars.js";
import { pool } from "./database.js";

const app = express();
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const MySQLStore = expressMySQLSession(session);
// /// con
// const storage = multer.diskStorage({
// //define el destino o la carpeata a utilizar dentro del proyecto
//   destination: function(req, file, cd){
//     cd(null, path.join(__dirname,'upload'))
//   }, 
//   ///defien el nombre de imgen
//   filename: function(req,file,cb){
// const uniqueSuffix =Date.now() +'-'+Math.round(Math.random()*1E9)+path.extname(file.originalname)
// cb(null, file.fieldname + '-' +uniqueSuffix)
//   }
// })

// export const upload = multer({storage:storage})



app.set("views", path.join(__dirname, "views"));
app.engine(
  ".hbs",
  create({
    defaultLayout: "main",
    layoutsDir: path.join(app.get("views"), "layouts"),
    partialsDir: path.join(app.get("views"), "partials"),
    extname: ".hbs",
    helpers
  }).engine
);
app.set("view engine", ".hbs");

app.use(morgan("dev"));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(cookieParser("ProgrammingHome"));
app.use(
  session({
    secret: "ProgrammingHome",
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore({}, pool),
  })
);
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());

app.use((req, res, next) => {
  app.locals.success = req.flash("success");
  app.locals.error = req.flash("error");
  app.locals.errors = req.flash("errors");
  app.locals.user = req.user;
  next();
});

app.use(routes);

app.use(express.static(path.join(__dirname, "public")));
// app.use(express.static(path.join(__dirname, "uploads")));
app.use((req, res, next) => {
  const err = new Error("Not Found");
  
  err.status = 404;
  next(err);
});

app.use((err, req, res, next) => {
  console.log(err)
  res.status(err.status || 500);
  res.render("error", {
    message: err.message,
    status: err.status,
  });
});

export default app;

