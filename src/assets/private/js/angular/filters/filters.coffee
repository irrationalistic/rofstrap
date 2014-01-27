angular.module('adminApp.filters', [])
  .filter 'interpolate', (version)->
    (text)->
      String(text).replace /\%VERSION\%/mg, version