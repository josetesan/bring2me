
angular.module('ikuun', ['ngRoute', 'requestsService'])
	.config(appRouter);

function appRouter($routeProvider) {
	$routeProvider
   
    .when('/', { templateUrl: '/partials/main.html'})
   .when('/about', { templateUrl: '/partials/about_ikuun.html', controller: 'controllers/signinCtrl'})
   .when('/contact', { templateUrl: '/partials/contact.html', controller: 'controllers/signinCtrl'})
   .when('/about-ikuun', { templateUrl: '/partials/about_ikuun.html', controller: 'controllers/loginCtrl'})
   .when('/how-it-works', { templateUrl: '/partials/how_it_works.html', controller: 'controllers/loginCtrl'})
   .when('/news', { templateUrl: '/partials/news.html', controller: 'controllers/loginCtrl'})
   .when('/legal', { templateUrl: '/partials/legal.html', controller: 'controllers/loginCtrl'})
   .when('/legal-ethics', { templateUrl: '/partials/legal_ethics.html', controller: 'controllers/loginCtrl'})
   .when('/legal-terms', { templateUrl: '/partials/legal_terms.html', controller: 'controllers/loginCtrl'})
   .when('/legal-relationships', { templateUrl: '/partials/legal_relationships.html', controller: 'controllers/loginCtrl'})
   .when('/legal-liability', { templateUrl: '/partials/legal_liability.html', controller: 'controllers/loginCtrl'})
   .when('/legal-privacy', { templateUrl: '/partials/legal_privacy.html', controller: 'controllers/loginCtrl'})
   .when('/legal-jurisdiction',  { templateUrl: '/partials/legal_jurisdiction.html', controller: 'controllers/loginCtrl'})
   .when('/login',  { templateUrl: '/partials/login.html', controller: 'controllers/loginCtrl'})
   .when('/app',   { templateUrl: '/partials/app_ikuun_activity.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-information',   { templateUrl: '/partials/app_user_information.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-modify-access',   { templateUrl: '/partials/app_user_change_pwd.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-rating',   { templateUrl: '/partials/app_user_rating.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-activity',   { templateUrl: '/partials/app_user_activity.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-create-request',   { templateUrl: '/partials/app_user_create_request.html', controller: 'controllers/signinCtrl'})
   .when('/es',   { templateUrl: '/partials/es/es_index.html', controller: 'controllers/signinCtrl'});

}

