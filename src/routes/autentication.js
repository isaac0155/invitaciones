const express = require('express');
const router = express.Router();
const passport = require('passport');
const {isLoggedIn} = require('../lib/auth')
const { isNotLoggedIn } = require('../lib/auth')
const pool = require('../database');

router.get('/signin/:newurl(*)', isNotLoggedIn,async (req, res) => {
    //console.log("Accediendo a: ", req.params.newurl);
    const newUrl = req.params.newurl;
    // Renderiza la plantilla, pasando el `newUrl` como una variable local
    res.render('/invitacion/confirmar', { url: newUrl });
});
router.get('/signin', isNotLoggedIn, async(req, res)=>{
    res.render('index');
});

router.post('/signin', (req, res, next) => {
    //console.log('Request body:', req.body);
    passport.authenticate('local.signin', {
        successRedirect: '/invitacion/confirmar',
        failureRedirect: '/',
        failureFlash: true
    })(req, res, next);
});

router.get('/profile',isLoggedIn,(req, res)=>{
    console.log(req.user)
    res.render('index');
});

router.get('/logout', isLoggedIn, (req, res, next)=>{
    req.logOut(function(err){
        if(err){
            console.log(err)
            next(err);
        }else{
            res.redirect('/');
        }
    });
});

module.exports = router;