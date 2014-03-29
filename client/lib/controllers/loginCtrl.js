function loginCtrlSignIn($scope,$http) {
	
	$scope.login = function () {

		$http({
			method : 'POST',
			url : '/app',
			data : $scope.user
		})
		.success(function(data, status, headers, config) {
			alert('Login successful '+status);
			// this callback will be called asynchronously
			// when the response is available
		})
		.error(function(data, status, headers, config) {
			// called asynchronously if an error occurs
			// or server returns response with an error status.
			alert('Error while log-in '+status);
		});
	};
}


