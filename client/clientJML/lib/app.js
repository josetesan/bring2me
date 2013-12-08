
angular.module('ikuun', ['ngRoute','requestsService'])
	.config(appRouter);



/* navigation  
----------------------------------------------------------------------------------------------------*/


function appRouter ($routeProvider) {
	$routeProvider
		.when('#', 		
      
      { templateUrl: 'requests.html' , 
      controller: 'requestsCtrl' }
      )
		
		.when('#about-ikuun', 
      { templateUrl: 'ikuun.html'    , 
      controller: 'loginCtrl'    }
      )

		.when('#about', 
      { templateUrl: 'partials/about.html'    , 
      controller: 'loginCtrl'    }
      )
		;
}




