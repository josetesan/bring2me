controllers.controller('MainCtrl', function($scope,$location, Auth) {


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
				toastr.success("You are signedin");
				$scope.main.credentials = {};
			}
		});

	};
	

});