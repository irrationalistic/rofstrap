describe 'Client App', ()->
  beforeEach module('myApp')

  describe 'IndexController', ()->
    beforeEach inject ($rootScope, $controller)->
      @scope = $rootScope.$new()
      $controller 'IndexController',
        $scope: @scope
    it 'should double numbers', ()->
      @scope.doubleIt()
      expect(@scope.x).toBe(6)

describe 'Admin App', ()->
  beforeEach module('adminApp')

  describe 'IndexController', ()->
    beforeEach inject ($rootScope, $controller)->
      @scope = $rootScope.$new()
      $controller 'IndexController',
        $scope: @scope
    it 'should double numbers', ()->
      @scope.doubleIt()
      expect(@scope.x).toBe(6)