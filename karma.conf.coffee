module.exports = (config) ->
	config.set

		# base path, that will be used to resolve all patterns, eg. files, exclude
		basePath: ''

		# frameworks to use
		frameworks: ['jasmine']

		# list of files / patterns to load in the browser
		files: [
			'http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.js'
			'http://ajax.googleapis.com/ajax/libs/angularjs/1.2.9/angular.js'
			'http://ajax.googleapis.com/ajax/libs/angularjs/1.2.9/angular-route.js'
			'http://ajax.googleapis.com/ajax/libs/angularjs/1.2.9/angular-resource.js'
			'http://ajax.googleapis.com/ajax/libs/angularjs/1.2.9/angular-mocks.js'
			'bower_components/ngprogress/build/ngProgress.min.js'
			'bower_components/foundation/js/foundation.min.js'
			'dist/assets/*/js/**/*.js'
			'.test/client/*-spec.js'
		]

		# list of files to exclude
		exclude: [

		]

		# test results reporter to use
		# possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
		reporters: ['spec', 'osx']

		# web server port
		port: 9876

		# enable / disable colors in the output (reporters and logs)
		colors: true

		# level of logging
		# possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
		logLevel: config.LOG_DISABLE

		# enable / disable watching file and executing tests whenever any file changes
		autoWatch: true

		# Start these browsers, currently available:
		# - Chrome
		# - ChromeCanary
		# - Firefox
		# - Opera (has to be installed with `npm install karma-opera-launcher`)
		# - Safari (only Mac; has to be installed with `npm install karma-safari-launcher`)
		# - PhantomJS
		# - IE (only Windows; has to be installed with `npm install karma-ie-launcher`)
		browsers: ['Chrome', 'PhantomJS']

		# If browser does not capture in given timeout [ms], kill it
		captureTimeout: 60000

		# Continuous Integration mode
		# if true, it capture browsers, run tests and exit
		singleRun: false
