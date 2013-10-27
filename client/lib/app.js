angular.module('bring2me', ['petitionsService'])
	.config(appRouter);

function appRouter ($routeProvider) {
	$routeProvider
		.when('/', 		{templateUrl: 'partials/petitions.html' , controller: 'petitionsCtrl' })
		.when('/login', {templateUrl: 'partials/login.html'     , controller: 'loginCtrl'});
}
