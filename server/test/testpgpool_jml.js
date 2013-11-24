var pg = require('pg');
var conString = "postgres://postgres:5432@localhost/postgres";

pg.connect(conString,function(err,client,done) {
	if (err) {
		return console.error('could not connect ',err);
	}
	var query = client.query('SELECT * from tb_currency');


	query.on('row',function(row,result) {
  		console.log(row.currency_currency_iso_name + ' created at '+ row.currency_created + ' is worth ' + row.currency_currency_fee);
  		result.addRow(row);
	});
	query.on('end',function(result) {
  		done();
  		console.log(result.rowCount + ' rows were received');
  		if (result.rowCount>0) 
	  		console.log(JSON.stringify(result.rows,null,"	"));
 		pg.end();	
	});
});