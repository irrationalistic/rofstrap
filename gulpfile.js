var gulp = require('gulp'),
    compass = require('gulp-compass'),
    stylus = require('gulp-stylus'),
    coffee = require('gulp-coffee'),
    ngmin = require('gulp-ngmin'),
    uglify = require('gulp-uglify'),
    concat = require('gulp-concat'),
    clean = require('gulp-clean'),
    header = require('gulp-header'),
    gulpif = require('gulp-if'),
    imagemin = require('gulp-imagemin'),
    nodemon = require('gulp-nodemon'),
    notify = require('gulp-notify'),
    open = require('gulp-open'),
    plumber = require('gulp-plumber'),
    util = require('gulp-util'),
    jade = require('gulp-jade'),
    useref = require('gulp-useref'),
    runSequence = require('run-sequence'),
    livereload = require('gulp-livereload'),
    lr = require('tiny-lr'),
    server = lr()
;

var config = {
    src: './src/',
    dist: './dist/'
};

var apps = ['public', 'private'];
var assets = ['public', 'private', 'common'];

var isBuild = util.env.build || false;

/**
 * Compile Stylus
 * @return {void}
 */
gulp.task('stylus', function(){
    var set = (isBuild) ? ['compress'] : ['linenos', 'nested'];
    return gulp.src(config.src + 'assets/**/*.styl')
        .pipe(stylus({
            set: set
        }))
        .pipe(gulp.dest(config.dist + 'assets/'))
        .pipe(livereload(server));
});

/**
 * Compile Sass
 * @return {void}
 */
gulp.task('sass', function(){
    var style = (isBuild) ? 'compressed': 'nested';
    return gulp.src(config.src + 'assets/**/*.{scss,sass}')
        .pipe(compass({
            css: config.dist + 'assets/',
            sass: config.src + 'assets/',
            project: './',
            import_path: 'bower_components/foundation/scss',
            style: style
        }))
        .pipe(livereload(server));
})

/**
 * Compile server-side coffee script
 * @return {void}
 */
gulp.task('serverCoffee', function(){
    var path = gulp.src(config.src + 'server.coffee')
        .pipe(coffee({bare: true}));
    if(isBuild)
        path.pipe(uglify());

    path.pipe(gulp.dest(config.dist));
    
    path = gulp.src(config.src + 'app/**/*.coffee')
        .pipe(coffee({bare: true}));
    if(isBuild)
        path.pipe(uglify());
    path.pipe(gulp.dest(config.dist + 'app/'));

    return path;
});

/**
 * Compile client-side coffee script (except angular files)
 * @return {void}
 */
gulp.task('clientCoffee', function(){
    var path = gulp.src([config.src + 'assets/**/*.coffee', '!**/js/angular/**/*.coffee'])
        .pipe(coffee({bare: true}));
    if(isBuild)
        path.pipe(uglify());
    path.pipe(gulp.dest(config.dist+'assets/'));
    return path;
});

/**
 * Compile angular applications
 * @return {void}
 */
gulp.task('angular', function(){
    for(var i = 0; i < apps.length; i++){
        var dst = gulp.dest(config.dist + 'assets/' + apps[i] + '/js/angular/');
        var path = gulp.src(config.src + 'assets/'+apps[i]+'/js/angular/**/*.coffee').pipe(coffee({bare: true}));
        if(isBuild)
            path.pipe(ngmin()).pipe(uglify()).pipe(concat('app.js')).pipe(dst);
        else
            path.pipe(dst);
        
    } 
});

/**
 * Compile angular jade templates to html
 * @return {void}
 */
gulp.task('angularTemplates', function(){
    return gulp.src(config.src + 'assets/**/*.jade')
        .pipe(jade({
            pretty: !isBuild
        }))
        .pipe(gulp.dest(config.dist + 'assets/'))
        .pipe(livereload(server));
});

/**
 * Preprocess server jade views
 * @return {void}
 */
gulp.task('pageTemplates', function(){
    var path = gulp.src(config.src + 'app/views/**/*.jade')
    if(isBuild)
        path.pipe(gulpif(isBuild, useref()));

    return path.pipe(gulp.dest(config.dist + 'app/views/'));
});

/**
 * Copy any vendor js, favicon.ico
 * @return {void}
 */
gulp.task('copy', function(){
    gulp.src(config.src+'/assets/common/favicon.ico').pipe(gulp.dest(config.dist+'/assets/common/'));
    return gulp.src(config.src+'/assets/**/*.js').pipe(gulp.dest(config.dist+'/assets'));
});

/**
 * Minify and copy images
 * @return {void}
 */
gulp.task('images', function(){
    return gulp.src(config.src+'**/*.{png,jpg,gif}')
        .pipe(imagemin({
            optimizationLevel: 3, progressive: true, interlaced: true
        }))
        .pipe(gulp.dest(config.dist));
});

/**
 * Clean out the dist and cache folders
 * @return {void}
 */
gulp.task('clean', function(){
    return gulp.src([
        config.dist,
        './.sass-cache'
    ], {read: false}).pipe(clean());
});
gulp.task('cleanSassCache', function(){
    return gulp.src('./.sass-cache', {read: false}).pipe(clean());
});

/**
 * Development task with watching
 * @return {void}
 */
gulp.task('default', function(){
    runSequence(
        'clean', 
        [
            'serverCoffee', 'clientCoffee', 'angular',
            'stylus', 'sass', 'copy', 'angularTemplates', 'pageTemplates'
        ],
        function(){
            if(isBuild){
                gulp.start('cleanSassCache');
            } else {
                nodemon({script: config.dist+'server.js', options: '--watch '+config.dist+'app'});
                server.listen(35729, function (err) {
                    if (err)
                      return console.log(err);

                    // WATCH COFFEE
                    gulp.watch([config.src + 'app/**/*.coffee',config.src + 'server.coffee'], ['serverCoffee']);
                    gulp.watch([config.src + 'assets/**/*.coffee', '!**/js/angular/**/*.coffee'], ['clientCoffee']);

                    // WATCH STYLES
                    gulp.watch(config.src + 'assets/**/*.styl', ['stylus']);
                    gulp.watch(config.src + 'assets/**/*.{scss,sass}', ['sass']);

                    // COPY
                    gulp.watch([
                        config.src+'/assets/**/*.js',
                        config.src+'/assets/common/favicon.ico'
                    ], ['copy']);

                    // IMAGES
                    gulp.watch(config.src+'**/*.{png,jpg,gif}', ['images']);

                    // ANGULAR
                    gulp.watch(config.src + 'assets/*/js/angular/**/*.coffee', ['angular']);
                    gulp.watch(config.src + 'assets/**/*.jade', ['angularTemplates']);

                    // SERVER TEMPLATES
                    gulp.watch(config.src + 'app/views/**/*.jade', ['pageTemplates']);
                });
            }
        }
    );
});