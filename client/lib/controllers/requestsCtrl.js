function requestsCtrl($scope, $http, DBRequest) {

	$scope.requests = DBRequest.query();

	$scope.createOrder = function(req_id,u_id) {


		var order = {
			request_id = req_id;
			user_id = u_id;
		};

		$http({
				method : 'POST',
				url    : '/order',
				data   : order
			})
			.success(function(data, status, headers, config) {
				alert('Order created ! ');
				// this callback will be called asynchronously
				// when the response is available
			})
			.error(function(data, status, headers, config) {
				// called asynchronously if an error occurs
				// or server returns response with an error status.
				alert('Error while creating an order ');
			});

	};

	$scope.rejectOrder = function() {

	}

}