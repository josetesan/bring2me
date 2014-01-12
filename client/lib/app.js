angular.module('ikuun', ['ngRoute','requestsService'])
	.config(appRouter);

function appRouter ($routeProvider) {
	$routeProvider
		.when('/', 		 { templateUrl: 'partials/requests.html' , controller: 'requestsCtrl' })
		.when('/signin', { templateUrl: 'partials/signin.html'    , controller: 'signinCtrl'    })
		.when('/legal',  { templateUrl: 'partials/legal.html'})
		.when('/contact',{ templateUrl: 'partials/contact.html'})
		.when('/signup', { templateUrl: 'partials/login.html',  controller: 'loginCtrl'});
}
