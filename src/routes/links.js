const helpers = require('../lib/helpers');
const shortid = require('shortid');
const express = require('express');
const router = express.Router();
const pool = require('../database');
const { isLoggedIn, isNovios } = require('../lib/auth');
const { body } = require('express-validator');
const { applyEach } = require('async');

var ret = (io) => {
    io.on("connection", async(socket) => {

        socket.on('cliente:eliminarInvitado', async (invitacionId, invitadoId) => {
            try {
                await pool.query('DELETE FROM personas WHERE id = ?', [invitadoId]);
                //const invitadosActualizados = await pool.query('SELECT * FROM personas WHERE id_invitacion = ?', [invitacionId]);
                io.emit('server:actualizarInvitados', invitacionId); // Actualizar a todos los clientes
            } catch (error) {
                console.error('Error al eliminar el invitado:', error);
                // Manejar el error 
            }
        });

        socket.on('cliente:editarInvitado', async (invitacionId, invitadoId, nuevoNombre) => {
            try {
                await pool.query('UPDATE personas SET nombre = ? WHERE id = ?', [nuevoNombre, invitadoId]);
                //const invitadosActualizados = await pool.query('SELECT * FROM personas WHERE id_invitacion = ?', [invitacionId]);
                io.emit('server:actualizarInvitados', invitacionId);
            } catch (error) {
                console.error('Error al editar el invitado:', error);
                // Manejar el error
            }
        });

        socket.on('cliente:agregarInvitado', async (data) => {
            try {
                let { nombre, id_invitacion } = data
                console.log('INSERT INTO personas (nombre, id_invitacion, id_boda) values (?, ?, 12102024);', [nombre, id_invitacion])
                const result = await pool.query('INSERT INTO personas (nombre, id_invitacion, id_boda) values (?, ?, 12102024);', [nombre, id_invitacion]);
                const nuevoInvitado = { id: result.insertId, nombre };
                io.emit('server:actualizarInvitados', id_invitacion); // Se puede usar un evento diferente para agregar
            } catch (error) {
                console.error('Error al agregar el invitado:', error);
                // Manejar el error
            }
        });

        socket.on('cliente:guardarInvitacion', async (invitacionId, nombreInvitacion, contacto) => {
            try {
                await pool.query('UPDATE invitaciones SET nombre = ?, contacto = ? WHERE id = ?', [nombreInvitacion, contacto, invitacionId]);
                // Puedes emitir un evento de éxito al cliente si es necesario
                io.emit('server:actualizarInvitados', invitacionId);
            } catch (error) {
                console.error('Error al guardar la invitación:', error);
                // Manejar el error 
            }
        });

        // Validar nombre de la invitación
        socket.on('client:getinvitados', async function (id) {
            let invitados = await pool.query('select a.* from personas a, invitaciones b where a.id_invitacion = b.id and b.id = ?', [ id])
            let invitacion = await pool.query('select * from invitaciones WHERE id = ?', [+id])
            
            //console.log(invitacion, 'select * from invitaciones WHERE id = ?', id, invitados)
            socket.emit('server:invitados', invitados, invitacion[0])
        });
        socket.on('cliente:invitado_check', async function (id, status) {
            let estado = status == true ? 1:0
            let data = await pool.query('update invitaciones set invitado = ? where id = ?', [estado, id])
            
            //console.log(data.insertId, id, contact)
            socket.emit('notification', '', id)
        });
        socket.on('client:contact_new', async function (id, contact) {
            let data = await pool.query('update invitaciones set contacto = ? where id = ?', [contact, id])
            
            console.log(data.insertId, id, contact)
            socket.emit('notification', '', id)
        });
        socket.on('cliente:getinvitacion', async function (id) {
            let invitacion = await pool.query('select * from invitaciones WHERE id = ?', [id])
            let personas = await pool.query('select * from personas where id_invitacion = ?', [id])
            //console.log(personas)
            socket.emit('server:getinvitacion', invitacion[0], personas)
        });
        socket.on('cliente:resetInvitacion', async function (id) {
            await pool.query('update invitaciones set estado = "pendiente" WHERE id = ?', [id])
            await pool.query('update personas set estado = "pendiente" where id_invitacion = ?', [id])
            socket.emit('notification', 'Se ha reseteado la Invitación', id)
        });
        socket.on('validarNombreInvitacion', async function (nombre) {
            await pool.query('SELECT COUNT(*) AS count FROM invitaciones WHERE nombre = ?', [nombre], function (err, results) {
                if (err) throw err;
                socket.emit('validarNombreInvitacion', { existe: results[0].count > 0 });
            });
        });
        socket.on('client:confirmar', async (invitados) => {
            var invitacion = 'rechazado';

            for (let element of invitados) {
                await pool.query('UPDATE personas SET estado = ? WHERE id = ?', [element.estado, element.id]);
                invitacion = element.estado == 'confirmado' ? 'confirmado' : invitacion;
            }

            await pool.query('UPDATE invitaciones SET estado = ? WHERE id = ?', [invitacion, invitados[0].id_invitacion]);
            socket.emit('server:reload');
            console.log(invitados);
        });
        socket.on('validarCodigoInvitacion', async function (codigo) {
            await pool.query('SELECT COUNT(*) AS count FROM invitaciones WHERE codigo = ?', [codigo], function (err, results) {
                if (err) throw err;
                socket.emit('validarCodigoInvitacion', { existe: results[0].count > 0 });
            });
        });

        socket.on('guardarInvitacion', async function (data) {
            const { codigo, nombre, personas } = data;

            await pool.query('INSERT INTO invitaciones (codigo, nombre, id_boda) VALUES (?, ?, ?)', [codigo, nombre, '12102024'], function (err, result) {
                if (err) {
                    socket.emit('guardarInvitacion', { exito: false });
                } else {
                    const id_invitacion = result.insertId;
                    //console.log(personas[0])
                    if(personas[0] != ''){
                        const personaQueries = personas.map(nombrePersona => {
                            return new Promise(async(resolve, reject) => {
                                await pool.query('INSERT INTO personas (nombre, id_invitacion, id_boda) VALUES (?, ?, ?)', [nombrePersona, id_invitacion, '12102024'], function (err) {
                                    if (err) reject(err);
                                    else resolve();
                                });
                            });
                        });   

                        Promise.all(personaQueries).then(() => {
                            socket.emit('guardarInvitacion', { exito: true });
                        }).catch(() => {
                            socket.emit('guardarInvitacion', { exito: false });
                        });
                    }else{
                        socket.emit('guardarInvitacion', { exito: true });
                    }
                }
            });
        });

    });
    /** */
    router.get('/profile/modify', isLoggedIn, async (req, res) => {
        res.render('links/index');
    });
    router.get('/jira', async (req, res) => {
        console.log(body)
        res.send('hola')
    });
    router.get('/novios', isNovios, async (req, res) => {
        //console.log(req.user)
        var fecha = new Date(req.user.fecha).toLocaleString().split(', ')[0]
        var eventos = await pool.query('select * from evento where id_boda = ? order by hora', [req.user.id])
        eventos.forEach(element => {
            var newHora = String(element.hora).split(':')
            element.hora = newHora[0]+':'+newHora[1]
        });
        let aceptados = await pool.query('select count(*) cantidad from personas where estado = "confirmado"')
        res.render('rutas/novios', {fecha, eventos, aceptados: aceptados[0].cantidad})
    });
    router.get('/novios/invitados', isNovios, async (req, res) => {
        //console.log(req.user)
        var principal = await pool.query('select * from personas where id_boda = ? and tipo = "principal"', [req.user.id])
        var reserva = await pool.query('select * from personas where id_boda = ? and tipo = "reserva"', [req.user.id])
        res.render('rutas/personas', {principal, reserva})
    });
    router.get('/novios/invitaciones', isNovios, async (req, res) => {
        var queryInvitacion = `
            SELECT
                i.*,
                COUNT(p.id) AS total_invitados,
                SUM(CASE WHEN p.estado = 'rechazado' THEN 1 ELSE 0 END) AS invitados_rechazados,
                SUM(CASE WHEN p.estado = 'confirmado' THEN 1 ELSE 0 END) AS invitados_aceptados,
                SUM(CASE WHEN p.estado = 'pendiente' THEN 1 ELSE 0 END) AS invitados_pendientes,
                GROUP_CONCAT(
                    CONCAT(
                        '{"id":', p.id, 
                        ',"nombre":"', p.nombre, 
                        '","estado":"', p.estado, 
                        '","tipo":"', p.tipo, 
                        '"}'
                    ) SEPARATOR ','
                ) AS invitados
            FROM
                invitaciones i
            INNER JOIN
                personas p ON i.id = p.id_invitacion
            WHERE
                i.id_boda = ?
                AND i.estado = ?
            GROUP BY
                i.id, i.codigo, i.id_boda, i.estado, i.nombre;
        `;


        let zoom = await pool.query(`SELECT * 
            FROM invitaciones 
            WHERE id NOT IN (SELECT DISTINCT id_invitacion FROM personas);
        `);
        var invitacionPendiente = await pool.query(queryInvitacion, [req.user.id, 'pendiente'])
        var invitacionConfirmado = await pool.query(queryInvitacion, [req.user.id, 'confirmado'])
        var invitacionRechazado = await pool.query(queryInvitacion, [req.user.id, 'rechazado'])
        let confirmados = await pool.query('select count(*) invitados from personas where estado = "confirmado"')
        let pendiente = await pool.query('select count(*) invitados from personas where estado = "pendiente"')
        let rechazado = await pool.query('select count(*) invitados from personas where estado = "rechazado"')

        invitacionPendiente.forEach(element => {
            element.invitados = JSON.parse(`[${element.invitados}]`);
        });

        invitacionConfirmado.forEach(element => {
            element.invitados = JSON.parse(`[${element.invitados}]`);
        });

        invitacionRechazado.forEach(element => {
            element.invitados = JSON.parse(`[${element.invitados}]`);
        });

        res.render('rutas/invitaciones', { invitacionPendiente, invitacionConfirmado, invitacionRechazado, confirmados: confirmados[0].invitados, pendientes: pendiente[0].invitados, rechazados: rechazado[0].invitados, zoom })
    });
    router.get('/confirmar', isLoggedIn, async (req, res) => {
        var invitacion = req.user
        var boda = await pool.query('select * from boda where id = ?', [invitacion.id_boda])
        var invitados = await pool.query('select * from personas where id_invitacion = ?', [invitacion.id])
        res.render('rutas/confirmar', { invitados1: JSON.stringify(invitados), boda:boda[0], invitados})
    });
    
    return router
}

module.exports = ret