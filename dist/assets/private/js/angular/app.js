var App;App=window.App=angular.module("adminApp",["ngRoute","ngProgress","adminApp.services","adminApp.filters","adminApp.controllers"]).config(["$routeProvider","$locationProvider",function(a,b){return a.when("/admin/",{controller:"IndexController",templateUrl:"/private/js/angular/partials/partial1.html"}).otherwise({redirectTo:"/admin/"}),b.html5Mode(!0)}]),angular.module("adminApp.controllers",[]).controller("IndexController",["$scope",function(a){return a.title="Index Controller",a.x=3,a.y=4,a.doubleIt=function(){return a.x*=2,a.y*=2}}]),angular.module("adminApp.filters",[]).filter("interpolate",["version",function(a){return function(b){return String(b).replace(/\%VERSION\%/gm,a)}}]),angular.module("adminApp.services",[]).value("version","1.0");