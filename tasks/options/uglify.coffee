module.exports =
  dist:
    files: [
        expand: true
        cwd: '<%= config.tempugl %>'
        src: ['**/*.js', '!assets/*/js/angular/**/*.js']
        dest: '<%= config.dist %>'
        ext: '.js'
      ,
        '<%= config.dist %>/assets/public/js/angular/app.js': '<%= config.tempugl %>/assets/public/js/angular/**/*.js'
        '<%= config.dist %>/assets/private/js/angular/app.js': '<%= config.tempugl %>/assets/private/js/angular/**/*.js'
    ]