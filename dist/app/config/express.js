var config, express, flash, passport, path;

flash = require('connect-flash');

express = require('express');

path = require('path');

passport = require('passport');

config = require('./config');

module.exports = function(app) {
  app.set('port', process.env.PORT || 3000);
  app.set('views', path.join(__dirname, '../views'));
  app.set('view engine', 'jade');
  app.use(express.favicon());
  if (config.env === 'development') {
    app.use(express.logger('dev'));
  }
  app.use(express.cookieParser());
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.session({
    secret: 'super secret string'
  }));
  app.use(flash());
  if (config.env === 'development') {
    app.use(express.errorHandler());
  }
  app.use(passport.initialize());
  app.use(passport.session());
  require('../config/passport')(app);
  app.use(express.compress({
    threshold: 0
  }));
  app.use('/public', express["static"](path.join(__dirname, '../../assets/public')));
  app.use('/common', express["static"](path.join(__dirname, '../../assets/common')));
  app.use('/components', express["static"](path.join(__dirname, '../../../bower_components')));
  app.use(function(req, res, next) {
    if (req.url.match(/^\/private\//)) {
      if (req.isAuthenticated()) {
        return next();
      }
      return res.send(401);
    } else {
      return next();
    }
  });
  app.use('/private', express["static"](path.join(__dirname, '../../assets/private')));
  app.use(app.router);
  return require('../config/routes')(app);
};
