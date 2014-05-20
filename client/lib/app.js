
angular.module('ikuun', ['ngRoute', 'requestsService'])
	.config(appRouter);

function appRouter($routeProvider) {
	$routeProvider
   
   .when('/', { templateUrl: '/partials/main.html'})
   .when('/about', { templateUrl: '/partials/about_ikuun.html', controller: 'controllers/signinCtrl'})
   .when('/contact', { templateUrl: '/partials/contact.html', controller: 'controllers/contactCtrl'})
   .when('/about-ikuun', { templateUrl: '/partials/about_ikuun.html'})
   .when('/how-it-works', { templateUrl: '/partials/how_it_works.html'})
   .when('/news', { templateUrl: '/partials/news.html', controller: 'controllers/newsCtrl'})
   .when('/legal', { templateUrl: '/partials/legal.html'})
   .when('/legal-information',  { templateUrl: '/partials/legal_information.html'})
   .when('/login',  { templateUrl: '/partials/login.html', controller: 'controllers/loginCtrl'})
   .when('/app',   { templateUrl: '/partials/app_ikuun_activity.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-information',   { templateUrl: '/partials/app_user_information.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-modify-access',   { templateUrl: '/partials/app_user_change_pwd.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-rating',   { templateUrl: '/partials/app_user_rating.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-activity',   { templateUrl: '/partials/app_user_activity.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-create-request-car',   { templateUrl: '/partials/app_user_create_request_car.html', controller: 'controllers/signinCtrl'})
   .when('/app/user-create-request-stuff',   { templateUrl: '/partials/app_user_create_request_stuff.html', controller: 'controllers/signinCtrl'})

}
