angular.module('petitionsService',['ngResource'])
	.factory('DBPetition',function ($resource) {
		return $resource('/petitions');
	}
);

//angular.module('petitionsService',[]) 
//	.factory('DBPetition', function($http) {
//		return $http.get('/petitions');
//	}
//);