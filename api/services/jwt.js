'use strict'

var jwt = require('jwt-simple');
var moment = require('moment');
var secret = 'clave_secreta';

exports.createToken = function(persona){
    var payload = {
        ci:persona.ci,
        nombre: persona.nombre,
        apellido: persona.apellido,
        email: persona.email,
        id_role: persona.id_role,
        iat: moment().unix(),
        exp: moment().add(30,'days').unix
    };
    return jwt.encode(payload, secret);
}