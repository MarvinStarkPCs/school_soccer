module.exports = {
  isNotLoggedIn(req, res, next) {
    if (req.isAuthenticated()) {
      return res.status(302).redirect(req.originalUrl || "/profile");
    }
    return next();
  },
  isLoggedIn(req, res, next) {
    if (!req.isAuthenticated()) {
      req.flash('message', 'Debe Iniciar sesion');  // Setting a flash message
      return res.status(401).redirect("/signin");    // Redirecting to the login page
    }
    next();  // Proceeding to the next middleware/route handler
  },
  redirectToHomeIfLoggedIn(req, res, next) {
    if (req.isAuthenticated()) {
      return res.redirect("/profile"); // Redireccionar a la página de inicio
    }
    next();
  },
};
