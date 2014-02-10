App = window.App = angular.module('adminApp',
  ['ngRoute', 'ngProgress', 'adminApp.services', 'adminApp.filters', 'adminApp.controllers']
).config ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/admin/',
      controller: 'IndexController'
      templateUrl: '/private/js/angular/partials/home.html'
    .otherwise
      redirectTo: '/admin/'
  $locationProvider.html5Mode true