function requestsCtrl($scope, $http, DBRequest) {

	$scope.requests = DBRequest.query();

	$scope.createOrder = function(request_id,user_id) {

		$http({
				method : 'POST',
				url    : '/order',
				data   : request_id,user_id
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