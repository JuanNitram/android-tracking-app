'use strict'

var express = require('express');
var api = express.Router();
var posicionModel = require('../models/posicion');
var md_auth = require('../middlewares/authenticated');

api.post('/posiciones', md_auth.ensureAuth, function(req,res){
    var posicionData={
        ci_persona: req.body.ci_persona,
        fecha: req.body.fecha,
        hora: req.body.hora,
        latitud: req.body.latitud,
        longitud: req.body.longitud
    }
    posicionModel.insertPosicion(posicionData,function(err,result){
        if(result){
            res.send({ message : 'Posicion registrada!'});
        }
        else{
            res.send({ message : 'Hubo un error!'});
        }
    });
});

module.exports = api;