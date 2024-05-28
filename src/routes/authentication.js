const express = require('express');
const router = express.Router();

const passport = require('passport');
const { redirectToHomeIfLoggedIn} = require('../lib/auth');

// SIGNUP
router.get('/signup', (req, res) => {
  res.render('auth/signup');
});

router.post('/signup', passport.authenticate('local.signup', {
  successRedirect: '/profile',
  failureRedirect: '/signup',
  failureFlash: true
}));

// SINGIN
router.get('/signin',redirectToHomeIfLoggedIn,(req, res) => {
  res.render('auth/signin');
});

router.post('/signin', redirectToHomeIfLoggedIn, (req, res, next) => {
  req.check('username', 'Username is Required').notEmpty();
  req.check('password', 'Password is Required').notEmpty();
  const errors = req.validationErrors();
  if (errors.length > 0) {
    req.flash('message', errors[0].msg);
    res.redirect('/signin');
  }
  passport.authenticate('local.signin', {
    successRedirect: '/profile',
    failureRedirect: '/signin',
    failureFlash: true
  })(req, res, next);
});

router.get('/logout', (req, res) => {
req.logOut();
res.redirect('/');
console.log("entre al logut")
});

router.get('/profile', (req, res) => {
  res.render('profile');
});

module.exports = router;
