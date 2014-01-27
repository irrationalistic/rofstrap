App = window.App = angular.module('myApp',
  ['ngRoute', 'ngProgress', 'myApp.services', 'myApp.filters', 'myApp.controllers']
).config ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      controller: 'IndexController'
      templateUrl: '/public/js/angular/partials/partial1.html'
    .otherwise
      redirectTo: '/'
  $locationProvider.html5Mode true