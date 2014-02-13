module.exports =
  dev:
    files: [
      expand: true
      cwd: '<%= config.src %>/assets'
      src: ['**/*.styl', '!**/_*.styl', '!vendor/**/*.stl']
      dest: '<%= config.dist %>/assets'
      ext: '.css'
    ]
    options:
      compress: false
      linenos: true
  dist:
    files: '<%= stylus.dev.files %>'
    options:
      compress: true
      linenos: false