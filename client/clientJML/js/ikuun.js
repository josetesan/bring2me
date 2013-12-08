var app = angular.module('bring2me',[]);

function DropdownCtrl($scope) {
  $scope.items = [
    "The first choice!",
    "And another choice for you.",
    "but wait! A third!"
  ];
}