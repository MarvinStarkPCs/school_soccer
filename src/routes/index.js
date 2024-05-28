const express = require('express');
const router = express.Router();
const { redirectToHomeIfLoggedIn,isNotLoggedIn} = require('../lib/auth');

router.get('/',redirectToHomeIfLoggedIn, isNotLoggedIn, async (req, res) => {
    res.render('index');
});

module.exports = router;