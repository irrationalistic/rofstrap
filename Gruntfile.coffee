module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  config =
    dist: 'dist'
    src: 'src'
    test: '.test'
    temp: '.tmp'
    tempmin: '.tmp/ngmin'
    tempugl: '.tmp/uglify'
    sassCache: '.sass-cache'

  grunt.initConfig
    config: config
    pkg: grunt.file.readJSON 'package.json'

    ###
      Clean out all directories
    ###
    clean:
      dist: '<%= config.dist %>'
      temp: '<%= config.temp %>'
      test: '<%= config.test %>'
      sass: '<%= config.sassCache %>'

    ###
      Compile coffee to js
    ###
    coffee:
      options:
        bare: true
      dev:
        options:
          sourceMap: true
        files: [{
          expand: true
          cwd: '<%= config.src %>/assets'
          src: ['**/*.coffee']
          dest: '<%= config.dist %>/assets'
          ext: '.js'
        }]
      dist:
        options:
          sourceMap: false
        files: [
          {
            expand: true
            cwd: '<%= config.src %>/assets'
            src: ['**/*.coffee', '!*/js/angular/**/*.coffee']
            dest: '<%= config.tempmin %>/assets'
            ext: '.js'
          }
          {
            expand: true
            cwd: '<%= config.src %>/assets/public/js/angular'
            src: ['**/*.coffee']
            dest: '<%= config.tempmin %>/assets/public/js/angular'
            ext: '.js'
          }
          {
            expand: true
            cwd: '<%= config.src %>/assets/private/js/angular'
            src: ['**/*.coffee']
            dest: '<%= config.tempmin %>/assets/private/js/angular'
            ext: '.js'
          }
        ]
      server:
        options:
          sourceMap: false
        files: [{
          expand: true
          cwd: '<%= config.src %>'
          src: ['app/**/*.coffee', 'server.coffee']
          dest: '<%= config.dist %>'
          ext: '.js'
        }]
      test:
        options:
          sourceMap: false
        files: [{
          expand: true
          cwd: '<%= config.src %>/test'
          src: ['**/*.coffee']
          dest: '<%= config.test %>'
          ext: '.js'
        }]

    ###
      Compile stylus files, ignore files that
      start with '_'
    ###
    stylus:
      dev:
        files: [{
          expand: true
          cwd: '<%= config.src %>/assets'
          src: ['**/*.styl', '!**/_*.styl', '!vendor/**/*.stl']
          dest: '<%= config.dist %>/assets'
          ext: '.css'
        }]
        options:
          compress: false
          linenos: true
      dist:
        files: '<%= stylus.dev.files %>'
        options:
          compress: true
          linenos: false

    ###
      Compile scss/sass files, ignore files that
      start with '_'
    ###
    sass:
      dev:
        files: [{
          expand: true
          cwd: '<%= config.src %>/assets'
          src: ['**/*.{scss,sass}', '!**/_*.{scss,sass}', '!vendor/**/*.{scss,sass}']
          dest: '<%= config.dist %>/assets'
          ext: '.css'
        }]
        options:
          compass: true
          style: 'expanded'
          lineNumbers: true
          loadPath: [
            'bower_components/foundation/scss'
            'bower_components/foundation-icons/'
          ]
      dist:
        files: '<%= sass.dev.files %>'
        options:
          compass: true
          style: 'compressed'
          lineNumbers: false
          loadPath: '<%= sass.dev.options.loadPath %>'

    ###
      Minify client-side JS
    ###
    uglify:
      dist:
        files: [
          {
            expand: true
            cwd: '<%= config.tempugl %>'
            src: ['**/*.js', '!assets/*/js/angular/**/*.js']
            dest: '<%= config.dist %>'
            ext: '.js'
          }
          '<%= config.dist %>/assets/public/js/angular/app.js': '<%= config.tempugl %>/assets/public/js/angular/**/*.js'
          '<%= config.dist %>/assets/private/js/angular/app.js': '<%= config.tempugl %>/assets/private/js/angular/**/*.js'
        ]

    ###
      Copy all essential, but non-compiled
      files
    ###
    copy:
      js:
        files: [{
          expand: true
          cwd: '<%= config.src %>/assets'
          src: ['**/*.js']
          dest: '<%= config.dist %>/assets'
        }]

    ###
      Compile client-side jade templates
    ###
    jade:
      angular:
        files: [{
          expand: true
          cwd: '<%= config.src %>/assets'
          src: ['**/*.jade']
          dest: '<%= config.dist %>/assets'
          ext: '.html'
        }]

    ###
      Prep angular files for minification
    ###
    ngmin:
      dist:
        files: [{
          expand: true
          cwd: '<%= config.tempmin %>'
          src: ['**/*.js']
          dest: '<%= config.tempugl %>'
          ext: '.js'
        }]

    ###
      Run client unit tests
    ###
    karma:
      dist:
        configFile: 'karma.conf.coffee'
        singleRun: true
        browsers: ['PhantomJS']

    ###
      Run server unit tests
    ###
    jasmine_node:
      projectRoot: '<%= config.test %>/server'
      growl: true

    ###
      Run tasks concurrently
    ###
    concurrent:
      dev:
        tasks: ['nodemon', 'watch', 'open']
        options:
          logConcurrentOutput: true
      dist:
        tasks: [
          'coffee:dist'
          'coffee:server'
          'stylus:dist'
          'sass:dist'
          'copy'
          'jade'
          'preprocess:dist'
        ]

    ###
      Open the browser
    ###
    open:
      dev:
        path: 'http://localhost:3000'

    ###
      Run nodemon
    ###
    nodemon:
      dev:
        options:
          file: './<%= config.dist %>/server.js'
          watchedFolders: ['dist/app']

    ###
      Preprocess server-side jade templates
    ###
    preprocess:
      dev:
        files: [{
          expand: true
          cwd: '<%= config.src %>/app/views'
          src: ['**/*.jade']
          dest: '<%= config.dist %>/app/views'
        }]
        options:
          context:
            production: false
      dist:
        files: '<%= preprocess.dev.files %>'
        options:
          context:
            production: true


    ###
      Minify and optimize images
    ###
    imagemin:
      dist:
        files: [{
          expand: true
          cwd: '<%= config.src %>/assets'
          src: ['**/*.{png,jpg,gif}']
          dest: '<%= config.dist %>/assets'
        }]
      options:
        cache: false


    ###
      List all available tasks
    ###
    availabletasks:
      tasks:
        options:
          sort: false
          filter: 'include'
          tasks: ['dev', 'dist', 'test']
          descriptions:
            'dev': 'Development task for watching, compiling, and testing files'
            'dist': 'Build task that compiles and minifies files'
            'test': 'Run client and server tests'


    ###
      Watch for file changes
    ###
    watch:
      options:
        livereload: true

      coffeeServer:
        files: [
          '<%= config.src %>/app/**/*.coffee'
          '<%= config.src %>/server.coffee'
        ]
        tasks: ['newer:coffee:server', 'jasmine_node']
      coffeeClient:
        files: ['<%= config.src %>/assets/**/*.coffee']
        tasks: ['newer:coffee:dev', 'karma']
      coffeeTestClient:
        files: ['<%= config.src %>/test/client/**/*.coffee']
        tasks: ['newer:coffee:test', 'karma']
        options:
          livereload: false
      coffeeTestServer:
        files: ['<%= config.src %>/test/server/**/*.coffee']
        tasks: ['newer:coffee:test', 'jasmine_node']
        options:
          livereload: false

      stylus:
        files: ['<%= config.src %>/assets/**/*.styl']
        tasks: ['stylus:dev']
      sass:
        files: ['<%= config.src %>/assets/**/*.{scss,sass}']
        tasks: ['sass:dev']

      preprocess:
        files: ['<%= config.src %>/app/views/**/*.jade']
        tasks: ['newer:preprocess:dev']

      copyJS:
        files: ['<%= config.src %>/assets/**/*.js']
        tasks: ['newer:copy:js']

      jadeAngular:
        files: ['<%= config.src %>/assets/js/angular/**/*.jade']
        tasks: ['newer:jade:angular']

      imagemin:
        files: ['<%= config.src %>/assets/*/images/*']
        tasks: ['newer:imagemin:dist']

  grunt.registerTask 'dev', [
    'clean'
    'coffee:dev'
    'coffee:server'
    'coffee:test'
    'stylus:dev'
    'sass:dev'
    'imagemin:dist'
    'copy'
    'jade'
    'preprocess:dev'
    'concurrent:dev'
  ]

  grunt.registerTask 'dist', [
    'clean'
    'concurrent:dist'
    'ngmin'
    'uglify'
    'clean:temp'
    'imagemin:dist'
    'coffee:test'
    'karma'
    'jasmine_node'
    'clean:test'
    'clean:sass'
  ]

  grunt.registerTask 'test', [
    'clean:test'
    'coffee:test'
    'coffee:dev'
    'karma'
    'jasmine_node'
  ]

  grunt.registerTask 'default', 'availabletasks'