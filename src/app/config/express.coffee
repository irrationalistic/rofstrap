flash = require 'connect-flash'
express = require 'express'
path = require 'path'
passport = require 'passport'

module.exports = (app)->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', path.join(__dirname, '../views')
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.session({ secret: 'super secret string' })
  app.use flash()

  if(app.get('env') == 'development')
    app.use express.errorHandler()

  # SET UP PASSPORT
  app.use(passport.initialize())
  app.use(passport.session())
  require('../config/passport')(app)

  # SET UP PUBLIC AND PRIVATE STATIC FILES
  app.use '/public', express.static(path.join(__dirname, '../../assets/public'))
  app.use '/common', express.static(path.join(__dirname, '../../assets/common'))
  app.use '/components', express.static(path.join(__dirname, '../../../bower_components'))
  app.use (req,res,next)->
    if req.url.match(/^\/private\//)
      return next() if req.isAuthenticated()
      res.send 401
    else
      next()
  app.use '/private', express.static(path.join(__dirname, '../../assets/private'))

  # USE THE APP ROUTER
  app.use app.router
  require('../config/routes')(app)