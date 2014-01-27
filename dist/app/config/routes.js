var ensureAuthenticated, ensureAuthenticatedCode, express, passport, routesAdmin, routesApi, routesIndex;

express = require('express');

passport = require('passport');

routesIndex = require('./../routes/');

routesAdmin = require('./../routes/admin');

routesApi = require('./../routes/api');

module.exports = function(app) {
  app.get('/admin/login', routesIndex.login);
  app.post('/admin/login', routesAdmin.loginPost);
  app.get('/admin/logout', routesAdmin.logout);
  app.get('/admin', ensureAuthenticated, routesAdmin.index);
  app.get('/admin/*', ensureAuthenticated, routesAdmin.index);
  app.get('/api', routesApi.index);
  return app.get('*', routesIndex.index);
};

ensureAuthenticated = function(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  return res.redirect('/admin/login');
};

ensureAuthenticatedCode = function(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  return res.send(401);
};
