# Rofstrap

Starter code that utilizes Node, Express, Grunt, Coffeescript, Sass or Stylus, Jade, Angular, and MongoDB. Server is run via Nodemon.

The default system includes Foundation using Sass.

Testing is performed with Karma and Jasmine on both front and backend.

Separate angular SPA's for both public and private sections of the site, using passport for authentication.

## Installation

Download files. Run `npm install` and then `bower install` to get dependencies.

### Setup
All source files are found in `src` folder. Inside this folder are the `app`, `assets`, and `test` folders.

#### app
Server-side source for the project. Make sure to edit the config files to set your project up initially. Passport defaults to the local-strategy, so this may need changing as well.

`config/routes.coffee` contains the entry point for all routes while the logic is handled in the `routes` folder. `routes/api.coffee` is for all the angular-based data connections. `routes/index.coffee` handles public connections for the SPA. `routes/admin.coffee` handles logic specific to the admin SPA. 

Models contains the root mongoose models as well as a folder for setting up database seeds. Seeds are automatically called in the `dev` environment from `config/mongoose.coffee`.

Views are sorted into common, private, and public. Common would contain all shared jade templates, while files specific to public are private are sorted accordingly. Note that `common/layout.jade` makes use of preprocessor directives that will be utilized during the dev and dist processes.

#### assets
These are files served via a static route for both public and private urls. Note that private files are routed through passport so as to protect them from prying eyes. You may use sass or stylus (and can also include custom grunt content for other languages), images are minified, js files are uglified, and coffee files are compiled. The angular applications are found here as well.

`common` contains all files that are available for both public and private.

`private` contains files protected by passport as well as the private angular app under `private/js/angular`

`public` contains publicly available files only as well as the public angular app under `public/js/angular`

#### test
Contains all server and client-side tests. These can be run with the `grunt test` task, are run automatically on file changes with `grunt dev`, or are run during compilation for `grunt dist`. 

## Grunt Tasks
Many of the tasks are done in sequence, so be careful when running individual tasks. Simply running `grunt` will list all available task sets.

### grunt dev
Watches local files for changes. Compiles all source and runs tests if necessary. Makes use of grunt newer for timestamp checking.

### grunt test
Special task for just running tests. Tests will be auto-run through dev task as well.

### grunt dist
Will minify and uglify source. All angular files will be run through ngmin to become minification-safe.


## Notes

`.slugignore` - used to help manage the included files in a heroku deploy.

`karma.conf.coffee` - defines settings for the karma test-runner.

running `grunt clean` will clean out the dist and temp folders.