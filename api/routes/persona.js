var express = require('express');
var api = express.Router();
var Persona = require('../models/persona');
var jwt = require('../services/jwt');
var md_auth = require('../middlewares/authenticated');

api.get('/personas', md_auth.ensureAuth, function(req,res){
    Persona.getPersonas(function(err,result){
        if(result){
            res.send({ result });
        }else{
            res.send({message : 'No hay personas!'});
        }
    });
});

api.post('/login',function(req,res){
    var personaData = {
        ci: req.body.ci,
        password: req.body.password
    }
    Persona.login(personaData, function(err,persona){
        if(JSON.stringify(persona) != '[]'){
            res.send({success: 1, response: { persona, token: jwt.createToken(persona) } });
        }else{
            res.send({success: 0, error:'Login incorrecto, verifique sus datos!'});
        }
    });
});

module.exports = api;