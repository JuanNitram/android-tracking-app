'use strict'

var connection = require('./dbConnection');

var posicionModel = {};

posicionModel.insertPosicion = function (posicionData, callback) {
    if(connection){
        connection.query('INSERT INTO Posiciones SET ?', posicionData,function (err,result){
            if(err) throw err;
            callback(null,{'insertId':result.insertId});
        });
    }
}

module.exports = posicionModel;