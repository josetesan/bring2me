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
      return logger.error('could not connect ',err);
    }

    var query  = client.query(' SELECT tb_user.user_nickname as alias, S.country_iso_country_name as source, D.country_iso_country_name as destination, '+
                              ' tb_request_master.request_description_package as subject, tb_currency.currency_currency_iso_name as currency, '+
                              ' tb_request_master.request_payment_money as reward FROM  tb_user,  tb_request_master,  tb_country_iso S, '+
                              ' tb_country_iso D,  tb_currency WHERE  tb_request_master.request_from_iso_country_id = S.country_id AND '+
                              ' tb_request_master.request_to_iso_country_id = D.country_id AND  tb_request_master.request_created_by_user_id = tb_user.user_id AND '+
                              ' tb_request_master.request_currency_id = tb_currency.currency_id');

    query.on('row',function(row,result) {
        logger.info(row.alias+ ' wants to get a '+ row.subject.trim() + ' from ' +
                    row.source.trim() + ' to '+ row.destination.trim() + ' for '+ row.reward + row.currency)  ;
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
console.log('Server running at http://127.0.0.1:8080);
logger.info(" Server started on port 8080\n");
