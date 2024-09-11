const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database'); // Asegúrate de que pool esté correctamente configurado

passport.use('local.signin', new LocalStrategy({
    usernameField: 'username',
    passwordField: 'password', // Ajustar o eliminar si no se usa
    passReqToCallback: true
}, async (req, username, password, done) => {
    try {
        const boda = await pool.query('select * from boda where code = ?', [username])
        if (boda.length > 0) {
            const user = boda[0];
            done(null, user, req.flash('success', 'Bienvenidos Novios'));
        } else {
            //console.log('Code received:', username);
            const rows = await pool.query('SELECT * FROM invitaciones WHERE codigo = ?', [username]);
            //console.log('Database rows:', rows);
            if (rows.length > 0) {
                const user = rows[0];
                done(null, user, req.flash('success', 'Bienvenido ' + user.name));
            } else {
                done(null, false, req.flash('danger', 'Codigo Incorrecto'));
            }
        }
    } catch (error) {
        return done(error);
    }
}));

passport.serializeUser((user, done) => {
    done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
    try {
        const boda = await pool.query('select * from boda where id = ?', [id])
        if (boda.length > 0) {
            const user = boda[0];
            done(null, user);
        } else {
            const rows = await pool.query('SELECT * FROM invitaciones WHERE id = ?', [id]);
            if (rows.length > 0) {
                done(null, rows[0]);
            } else {
                done(new Error('User not found'));
            }
        }
    } catch (error) {
        done(error);
    }
});
