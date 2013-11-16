var pg = require('pg');
var conString = "postgres://postgres:5432@localhost/bring2me";
var client = new pg.Client(conString);
module.exports = client;
