module.exports =
    angular:
        files: [
          expand: true
          cwd: '<%= config.src %>/assets'
          src: ['**/*.jade']
          dest: '<%= config.dist %>/assets'
          ext: '.html'
        ]