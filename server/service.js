//var http = require('http');
////var client = require("redis").createClient();
var compress = require('compression')()
//var csrf = require('csurf');
var favicon =  require('static-favicon');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var serveStatic = require('serve-static');
var winston = require('winston');
var conString = require('./config/postgres_pool.js');
var pg = require('pg');
var express = require('express');
var url= require('url');
var app = express();

app.use(compress);
//app.use(csrf());
app.use(bodyParser());
app.use(serveStatic('../client'))
app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(cookieParser('md5sumofconcatenatedvalues'));


app.get('/app', function  (request, response) {
  logger.info("Request received, answering with data");

  pg.connect(conString,function(err,client,done) {
    if (err) {
      return logger.error('could not connect ',err);
    }

  //  var query  = client.query('select * from fetch_new_request_main_page() ');

    var query  = client.query('select 1 ');

      
    query.on('row',function(row,result) {
        logger.info( ' wants to get a '+ row.v_subject.trim() + ' from ' +
                    row.v_source.trim() + ' to '+ row.v_destination.trim() + ' for '+ row.v_reward + row.v_currency)  ;
        result.addRow(row);
    });

    query.on('error', function(error) {
      logger.error('Error on querying',error);
    });

    query.on('end',function(result) {
        done();
        logger.info(result.rowCount + ' rows were received');
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

  var request_id = request.body.request_id;
  var user_id = request.body.user_id;

  logger.info(user_id +' has asked for '+request_id);

  pg.connect(conString,function(err,client,done) {
    if (err) {
      return logger.error('could not connect ',err);
    }

    // check maximum requests are not reached

    // update request counter

    // insert new order
    var query = client.query('INSERT INTO tb_request_action(action_request_master_id, action_claim_given_by_user_id) VALUES ($1,$2)',
                              [request_id, user_id]);

    query.on('error', function(error) {
      logger.error('Error on creating order :',error);
    });

    query.on('end',function(result) {
        done();
        logger.info("Order created "+result);
        // return order id
        response.json(result);
    });
  });
  
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

app.post('/login',function(request, response){
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
    new winston.transports.File({ filename: 'logs/b2me_service.log', json: false })
  ],
  exceptionHandlers: [
    new winston.transports.File({ filename: 'logs/b2me_exceptions.log', json: false })
  ],
  exitOnError: false
});


app.listen(8888); //8080
console.log('Server running at localhost:8888');
logger.info("Server started on port 8888\n");
