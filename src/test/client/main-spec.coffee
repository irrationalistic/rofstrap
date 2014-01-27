describe 'Array', ()->
  describe '#indexOf()', ()->
    it 'should return -1 when the value is not present', ()->
      expect(1).toEqual(1)
      expect(2).toEqual(2)

describe 'Utility', ()->
  describe '#console', ()->
    it 'should always have a console', ()->
      window.console = undefined
      expect(window.console).toBeUndefined()
      fixConsole()
      expect(window.console).not.toBeUndefined()

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