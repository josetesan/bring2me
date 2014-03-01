angular.module('ikuun', ['ngRoute','requestsService'])
	.config(appRouter);

function appRouter ($routeProvider) {
	$routeProvider
		.when('/', 		     { templateUrl: '/partials/main.html' })
		.when('/about',   { templateUrl: '/partials/about_ikuun.html' , controller: 'controllers/signinCtrl'    })
		.when('/contact', { templateUrl: '/partials/contact.html'     , controller: 'controllers/signinCtrl'    })
		.when('/login',  { templateUrl: '/partials/login.html'       , controller: 'controllers/loginCtrl'})
    	.when('/about-ikuun',  { templateUrl: '/partials/about_ikuun.html'       , controller: 'controllers/loginCtrl'})
    	.when('/legal-ethics',  { templateUrl: '/partials/legal_ethics.html'       , controller: 'controllers/loginCtrl'})
    	.when('/legal-terms',  { templateUrl: '/partials/legal_terms.html'       , controller: 'controllers/loginCtrl'})
    	.when('/legal-relationships',  { templateUrl: '/partials/legal_relationships.html', controller: 'controllers/loginCtrl'})
    	.when('/legal-liability',  { templateUrl: '/partials/legal_liability.html', controller: 'controllers/loginCtrl'})    
    	.when('/legal-privacy',  { templateUrl: '/partials/legal_privacy.html', controller: 'controllers/loginCtrl'})
        .when('/legal-jurisdiction',  { templateUrl: '/partials/legal_jurisdiction.html', controller: 'controllers/loginCtrl'})

		.when('/legal',  { templateUrl: '/partials/legal.html'       , controller: 'controllers/loginCtrl'});

}

