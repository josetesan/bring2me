
var app=angular.module('myApp', [])
.controller('myCtrl', function ($scope) {
})
.directive('hboTabs', function() {
    return {
        restrict: 'A',
        link: function(scope, elm, attrs) {
            var jqueryElm = $(elm[0]);
            $(jqueryElm).tabs()
        }
    };
})

