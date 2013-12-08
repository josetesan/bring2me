/* corousel 
----------------------------------------------------------------------------------------------------*/
angular.module('ikuun', ['ui.bootstrap']).controller('sliding',['$scope', function($scope){

  $scope.slides = [];
  $scope.slides.push({text: 'photo1adsf', image: 'http://placekitten.com/300/200'});
  $scope.slides.push({text: '2222', image: 'http://placekitten.com/301/200'});
  $scope.slides.push({text: '1', image: 'http://placekitten.com/302/200'});
}]);
