const express = require('express');
const morgan = require('morgan');
const { engine } = require('express-handlebars');
const path = require('path');
const flash = require('connect-flash');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session); // Import MySQLStore with session
const { database } = require('./keys');
const passport = require('passport');
import { Server as WebSocketServer } from "socket.io";
const http = require('http');
const https = require('https');
const fs = require('fs');
const device = require('express-device');
const { port } = require('./config.js');

// Inicializaciones
const app = express();

// Servidor HTTP
const server = http.createServer(app);

// Servidor HTTPS (cargar certificados desde la misma ruta)
const httpsOptions = {
    cert: fs.readFileSync('/etc/letsencrypt/live/isaaclisbeth.com/fullchain.pem'),
    key: fs.readFileSync('/etc/letsencrypt/live/isaaclisbeth.com/privkey.pem')
};

const httpsServer = https.createServer(httpsOptions, app);

// WebSocket Server (compartido entre HTTP y HTTPS)
const io = new WebSocketServer(httpsServer);

require('./lib/passport');

// Configuraciones
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', engine({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}));
app.set('view engine', '.hbs');

// Middlewares
app.use(session({
    secret: 'sesionrapidaMYSQL',
    resave: false,
    saveUninitialized: false,
    rolling: true,
    cookie: {
        path: '/',
        httpOnly: true,
        maxAge: 3600000 // 1 hora
    },
    store: new MySQLStore(database)
}));
app.use(device.capture());
app.use(flash());
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(passport.initialize());
app.use(passport.session());
app.set('trust proxy', true);

// Variables globales
app.use((req, res, next) => {
    app.locals.success = req.flash('success');
    app.locals.warning = req.flash('warning');
    app.locals.danger = req.flash('danger');
    app.locals.user = req.user;
    req.device.type === 'desktop' ? app.locals.desk = true : app.locals.desk = false;
    next();
});

// Archivos públicos
app.use(express.static(path.join(__dirname, 'public')));

// Rutas
//rutas
app.use(require('./routes/autentication'));
app.use('/invitacion', require('./routes/links')(io));
app.use(require('./routes/index'));


// Iniciar servidores HTTP y HTTPS
server.listen(port, () => {
    console.log('Servidor HTTP en el puerto', port);
});
httpsServer.listen(443, () => {
    console.log('Servidor HTTPS en el puerto 443');
});
