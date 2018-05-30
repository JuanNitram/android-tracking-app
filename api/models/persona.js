'use strict'

var connection = require('./dbConnection');

var personaModel = {};

personaModel.getPersonas = function(callback){
    if(connection){
        connection.query("SELECT * FROM Personas", function (err, result) {
            if (err) throw err;
            callback(null,result);
        });
    }
};

personaModel.login = function(personaData, callback){
    if(connection){
        var query = 'SELECT * FROM Personas WHERE ci =\'' + personaData.ci + '\' AND password = \''+ personaData.password +'\'';
        connection.query(query, function(err,result){
            if(err) throw err;
            callback(null,result);
        });
    }
}


/*function insertPersona(req, res) {
    var params = req.body;
    if (params.ci != null &&
        params.password != null &&
        params.nombre != null &&
        params.apellido != null &&
        params.email != null &&
        params.id_role != null) {

        var personaData = {
            ci: params.ci, 
            nombre: params.nombre,
            apellido: params.apellido,
            email: params.email,
            password: params.password,
            id_role: params.id_role};

        connection.query('INSERT INTO Personas SET ?', [personaData], function (err, result) {
            if (err) throw err;
            res.send({ result });
        });
    }
    else {
        res.send({ message: 'Faltan datos!' });
    }
}
*/

module.exports = personaModel;