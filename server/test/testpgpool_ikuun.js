var pg = require('pg');
var conString = "postgres://ikuunuser@localhost/ikuundb";

pg.connect(conString,function(err,client,done) {
	if (err) {
		return console.error('could not connect ',err);
	}
        var query = client.query('SELECT * from tb_country_iso');

	query.on('row',function(row,result) {
  		console.log(row.country_iso_country_name+ ' has '+ row.country_payment_fee_currency +' as currency');
  		result.addRow(row);
	});

	query.on('end',function(result) {
  		done();
  		console.log(result.rowCount + ' rows were received');
  		console.log(JSON.stringify(result.rows,null,"	"));
 		pg.end();	
	});
});
