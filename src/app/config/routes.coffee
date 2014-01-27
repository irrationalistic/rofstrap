express = require 'express'
passport = require 'passport'
routesIndex = require './../routes/'
routesAdmin = require './../routes/admin'
routesApi = require './../routes/api'

module.exports = (app)->
  # LOGIN/OUT
  app.get '/admin/login', routesIndex.login
  app.post '/admin/login', routesAdmin.loginPost
  app.get '/admin/logout', routesAdmin.logout

  # ADMIN ANGULAR PAGES
  app.get '/admin', ensureAuthenticated, routesAdmin.index
  app.get '/admin/*', ensureAuthenticated, routesAdmin.index

  # API
  app.get '/api', routesApi.index

  # FALLBACK
  app.get '*', routesIndex.index

ensureAuthenticated = (req, res, next)->
  return next() if req.isAuthenticated()
  res.redirect '/admin/login'
ensureAuthenticatedCode = (req, res, next)->
  return next() if req.isAuthenticated()
  res.send 401