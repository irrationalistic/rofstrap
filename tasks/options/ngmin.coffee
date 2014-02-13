module.exports =
    dist:
        files: [
          expand: true
          cwd: '<%= config.tempmin %>'
          src: ['**/*.js']
          dest: '<%= config.tempugl %>'
          ext: '.js'
        ]