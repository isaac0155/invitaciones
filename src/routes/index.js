const express = require('express');
const router = express.Router();

router.get('/', (req, res) =>{
    //res.redirect('/links');
    //console.log(req.user)
    res.render('index')
});
router.get('*', (req, res) => {
    res.render('vacio')
});

module.exports = router;