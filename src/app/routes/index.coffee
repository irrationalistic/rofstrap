module.exports.index = (req, res)->
  res.render 'public/index',
    title: 'My Site'
    ngApp: 'myApp'
    assetPath: 'public'


module.exports.login = (req, res)->
  res.render 'public/login',
    title: 'Login'
    ngApp: ''
    assetPath: 'public'