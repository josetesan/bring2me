controllers.controller('MainCtrl', function($scope,Auth) {


	$scope.main = {
			user : {},
	};

	$scope.login = function(){
		Auth.login({
			username : $scope.user.email,
			password : $scope.user.password

		}).success(function(data) {
			if (data.error) {
				toastr.error(data.error)
			} else {
				toastr.success("You are signed-in");
				$scope.main.credentials = {};
			}
		});

	};
	

});