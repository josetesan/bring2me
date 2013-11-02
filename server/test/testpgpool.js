var pg = require('pg');
var conString = "postgres://postgres:5432@localhost/bring2me";

pg.connect(conString,function(err,client,done) {
	if (err) {
		return console.error('could not connect ',err);
	}
	var query = client.query('SELECT SOURCE,DESTINATION,SUBJECT,REWARD,DUEDATE,OWNERID FROM REQUESTS');

	query.on('row',function(row,result) {
  		console.log(row.ownerid+ ' wants to get a '+ row.subject.trim() + ' from ' + row.source.trim() + ' to '+ row.destination.trim() + ' for '+ row.reward + '€')	;
  		result.addRow(row);
	});

	query.on('end',function(result) {
  		done();
  		console.log(result.rowCount + ' rows were received');
  		console.log(JSON.stringify(result.rows,null,"	"));
 		pg.end();	
	});
});