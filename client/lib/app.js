angular.module('ikuun', ['ngRoute','requestsService'])
	.config(appRouter);

function appRouter ($routeProvider) {
	$routeProvider
		.when('/', 		     { templateUrl: '/partials/main.html' })
		.when('/about',   { templateUrl: '/partials/about_ikuun.html' , controller: 'controllers/signinCtrl'    })
		.when('/contact', { templateUrl: '/partials/contact.html'     , controller: 'controllers/signinCtrl'    })
		.when('/login',  { templateUrl: '/partials/login.html'       , controller: 'controllers/loginCtrl'})
		.when('/legal',  { templateUrl: '/partials/legal.html'       , controller: 'controllers/loginCtrl'});

}

