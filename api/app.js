'use strict'

var express = require('express');
var bodyParser = require('body-parser');
var morgan = require('morgan');

var app = express();

var posicion_routes = require('./routes/posicion');
var persona_routes = require('./routes/persona');

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(morgan('dev'));

app.use('/api',posicion_routes);
app.use('/api',persona_routes);

module.exports = app;