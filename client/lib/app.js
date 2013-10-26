angular.module('bring2me', [])
	.config(appRouter);

function appRouter ($routeProvider) {
	$routeProvider
		.when('/', 		{templateUrl: 'partials/petitions.html' })
		.when('/login', {templateUrl: 'partials/login.html'     });
}


function AppController ($scope) {


	$scope.petitions =  {
	"01" : {
		"objeto": "Llaves",
		"origen": "Santander",
		"limite": "5/10/2013",
		"destino": "Madrid",
		"recompensa":"10€"
	} ,

	"02" : {
		"objeto": "Camiseta",
		"origen": "Barcelona",
		"limite": "12/12/2013",
		"destino": "Malaga",
		"recompensa": "5€"

	} ,

	"03" : {
		"objeto": "Cuaderno",
		"origen": "Gandia",
		"limite": "25/11/2013",
		"destino": "Vigo",
		"recompensa": "13€"
	}
};

}