var passport;

passport = require('passport');

module.exports.logout = function(req, res) {
  req.logout();
  return res.redirect('/');
};

module.exports.loginPost = function(req, res, next) {
  return passport.authenticate('local', function(err, user, info) {
    if (err) {
      return next(err);
    }
    if (!user) {
      req.session.messages = [info.message];
      return res.redirect('/admin/login');
    }
    return req.logIn(user, function(err) {
      if (err) {
        return next(err);
      }
      return res.redirect('/admin');
    });
  })(req, res, next);
};

module.exports.index = function(req, res) {
  return res.render('private/index', {
    title: 'Admin',
    ngApp: 'adminApp',
    assetPath: 'private'
  });
};
