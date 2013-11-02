angular.module('bring2me', ['requestsService'])
	.config(appRouter);

function appRouter ($routeProvider) {
	$routeProvider
		.when('/', 		{ templateUrl: 'partials/requests.html' , controller: 'requestsCtrl' })
		.when('/login', { templateUrl: 'partials/login.html'    , controller: 'loginCtrl'    });
}
