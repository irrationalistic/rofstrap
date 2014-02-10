module.exports.index = function(req, res) {
  return res.render('public/index', {
    title: 'My Site',
    ngApp: 'myApp',
    assetPath: 'public'
  });
};

module.exports.login = function(req, res) {
  return res.render('public/login', {
    title: 'Login',
    ngApp: '',
    assetPath: 'public'
  });
};
