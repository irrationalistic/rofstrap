angular.module('myApp.controllers', [])
  .controller 'IndexController', ($scope, $timeout, $log, ngProgress)->
    ngProgress.start()
    $timeout(
      ()->
        ngProgress.complete()
      , 1000
    )

    $scope.title = 'Index Controller'
    $scope.x = 3
    $scope.y = 4
    $scope.doubleIt = ()->
      $scope.x *= 2
      $scope.y *= 2