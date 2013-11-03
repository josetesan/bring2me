services.factory('Auth', function($http) {
	return {
		load : function() {
			return $http.get('/api/v1/auth/auth');
		},
		logout: function() {
			return $http.get('/api/v1/auth/logout');
		},
		login: function(inputs) {
			return $http.post('/api/v1/auth/login',inputs)
		},
		register: function(inputs) {
			return $http.post('/api/v1/auth/register',inputs);
		}
	}
}
);