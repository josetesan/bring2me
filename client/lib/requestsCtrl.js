function requestsCtrl($scope, DBRequest) {

	$scope.requests = DBRequest.query();

}