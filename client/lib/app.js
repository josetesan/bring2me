angular.module('ikuun', ['ngRoute','requestsService'])
	.config(appRouter);

function appRouter ($routeProvider) {
	$routeProvider
		.when('/', 		 { templateUrl: 'partials/requests.html' , controller: 'requestsCtrl' })
		.when('#/about',  { templateUrl: 'partials/about_ikuun.html'    , controller: 'signinCtrl'    })
		.when('#/contact',  { templateUrl: 'partials/contact.html'    , controller: 'signinCtrl'    })
		.when('#/signup', { templateUrl: 'partials/login.html',  controller: 'loginCtrl'});
		.when('#/legal', { templateUrl: 'partials/legal.html',  controller: 'loginCtrl'});

}


function SettingsController1() {
  this.name = "John Smith";
  this.contacts = [
    {type: 'phone', value: '408 555 1212'},
    {type: 'email', value: 'john.smith@example.org'} ];
  };

SettingsController1.prototype.greet = function() {
  alert(this.name);
};

SettingsController1.prototype.addContact = function() {
  this.contacts.push({type: 'email', value: 'yourname@example.org'});
};

SettingsController1.prototype.removeContact = function(contactToRemove) {
 var index = this.contacts.indexOf(contactToRemove);
  this.contacts.splice(index, 1);
};

SettingsController1.prototype.clearContact = function(contact) {
  contact.type = 'phone';
  contact.value = '';
};
