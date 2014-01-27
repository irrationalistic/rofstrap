angular.module('myApp.filters', [])
  .filter 'interpolate', (version)->
    (text)->
      String(text).replace /\%VERSION\%/mg, version