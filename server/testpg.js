var client = require('./config/postgres.js');

client.connect(function(err) {
	if (err) {
		return console.error('could not connect ',err);
	}
	var query = client.query('SELECT SOURCE,DESTINATION,SUBJECT,REWARD,DUEDATE,OWNERID FROM REQUESTS');

	query.on('row',function(row) {
  		console.log(row.ownerid+ ' wants to get a '+ row.subject.trim() + ' from ' + row.source.trim() + ' to '+ row.destination.trim() + ' for '+ row.reward + '€')	;
	});

	query.on('end',function(result) {
  		client.end();
  		console.log(result.rowCount + ' rows were received');
	});
});