angular.module('requestsService',['ngResource'])
	.factory('DBRequest',function ($resource) {
		return $resource('/requests');
	}
);

//angular.module('petitionsService',[]) 
//	.factory('DBPetition', function($http) {
//		return $http.get('/petitions');
//	}
//);