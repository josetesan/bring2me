var client = require('../config/postgres.js');

client.connect(function(err) {
	if (err) {
		return console.error('could not connect ',err);
	}
	var query = client.query('SELECT ACCEPTED_DATE,SOURCE,DESTINATION,SUBJECT,REWARD,DUEDATE, ALIAS, EMAIL '+
		 ' FROM REQUESTS R left join USERS U on (R.ownerid = U.user_id) ' +
		 ' left join ORDERS O on (O.request_id = R.id)');

	query.on('row',function(row,result) {
  		console.log(row.alias+ ' wants to get a '+ row.subject.trim() + ' from ' + row.source.trim() + ' to '+ row.destination.trim() + ' for '+ row.reward + '€')	;
  		result.addRow(row);
	});

	query.on('end',function(result) {
  		client.end();	
  		console.log(result.rowCount + ' rows were received');
  		console.log(JSON.stringify(result.rows,null,"	"));
	});
});