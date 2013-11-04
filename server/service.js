//var http = require('http');
//var client = require("redis").createClient();
var winston = require('winston');
var conString = require('./config/postgres_pool.js');
var pg = require('pg');
var express = require('express');
var app = express()
  .use(express.compress())
  .use(express.urlencoded())
  .use(express.json())
  .use(express.static('../client'))
  .use(express.favicon())
  .use(express.cookieParser('md5sumofconcatenatedvalues'));


app.get('/requests', function  (request, response) {
  logger.info("Request received, answering with data");

  pg.connect(conString,function(err,client,done) {
    if (err) {
      return console.error('could not connect ',err);
    }
    var query = client.query('SELECT R.ID,U.USER_ID,SOURCE,DESTINATION,SUBJECT,REWARD,DUEDATE,ALIAS,TIMES FROM REQUESTS R, USERS U where R.ownerid = U.user_id');

    query.on('row',function(row,result) {
        console.log(row.alias+ ' wants to get a '+ row.subject.trim() + ' from ' + row.source.trim() + ' to '+ row.destination.trim() + ' for '+ row.reward + '€')  ;
        result.addRow(row);
    });

    query.on('error', function(error) {
      console.log('Error on querying',error);
    });

    query.on('end',function(result) {
        done();
        console.log(result.rowCount + ' rows were received');
        response.json(result.rows);
    });

  });

});


app.post('/users', function (request,response) {

  logger.info("Receiving a post on users");

  var name = request.body.email;
  var password = request.body.password;

  logger.info("Received "+name+" with password " + password);
  

});



app.post('/order',function (request,response) {
  
  logger.info("An user has ordered a request");

  var requestId = request.body.request_id;
  var user_id = request.body.user_id;

  logger.info(user_id +' has asked for '+request_id);

  // check maximum requests are not reached

  // update request counter

  // insert new order
});



app.get('/api/v1/auth/auth',function(request, response){
	logger.info("Received authentication request\n");
	response.writeHead(200, {'Content-Type':'application/json'});
	response.write("auth:OK");
	response.end();
});

app.get('/api/v1/auth/logout',function(request, response){
	logger.info("Received logout request\n");
	response.writeHead(200, {'Content-Type':'application/json'});
	response.write("logout:OK");
	response.end();
});


app.post('/api/v1/auth/login',function(request, response){
	logger.info("Received login request\n")
	response.writeHead(200, {'Content-Type':'application/json'});
	response.write("login:OK");
	response.end();
});

app.post('/api/v1/auth/register',function(request, response){
	logger.info("Received register request\n");
	response.writeHead(201, {'Content-Type':'application/json'});
	response.write("register:OK");
	response.end();

});



function onRequest(request, response) {

    request.addListener("data", function(chunk) {	request.content += chunk;    });

    request.addListener("end", function() {
		logger.info("Finished receiving data");
   	});
};



var logger = new (winston.Logger)({
  transports: [
    new winston.transports.File({ filename: 'b2me_service.log', json: false })
  ],
  exceptionHandlers: [
    new winston.transports.File({ filename: 'b2me_exceptions.log', json: false })
  ],
  exitOnError: false
});


app.listen(8080);
console.log('Server running at http://127.0.0.1:8080');
logger.info(" Server started on port 8080\n");
