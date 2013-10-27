function petitionsCtrl($scope, DBPetition) {

	$scope.petitions = DBPetition.query();

}