module.exports ={

    isLoggedIn(req, res, next){
        //console.log(req.originalUrl)
        console.log(req.originalUrl)
        if (req.isAuthenticated()){
            if (req.user.cantidad_invitados && req.originalUrl != '/logout') {
                return res.redirect('/invitacion/novios');
            } else {
                return next();
            }
        }
        req.flash('warning', 'Ingresa el codigo para ver la página');
        var redirectUrl = '/';
        return res.redirect(redirectUrl);
    },
    isNotLoggedIn(req, res, next){
        if (!req.isAuthenticated()){
            return next();
        }
        return res.redirect('/');
    },
    isNovios(req, res, next){
        if (req.isAuthenticated() && req.user.cantidad_invitados){
            return next();
        }
        req.flash('warning', 'Ingresa el codigo para ver la página');
        return res.redirect('/');
    },
}