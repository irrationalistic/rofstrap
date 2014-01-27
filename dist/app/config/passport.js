var LocalStrategy, User, express, passport;

passport = require('passport');

express = require('express');

LocalStrategy = require('passport-local').Strategy;

User = require('./../models/user');

module.exports = function(app) {
  passport.serializeUser(function(user, done) {
    return done(null, user.id);
  });
  passport.deserializeUser(function(id, done) {
    return User.findById(id, function(err, user) {
      return done(err, user);
    });
  });
  return passport.use(new LocalStrategy(function(username, password, done) {
    return User.findOne({
      username: username
    }, function(err, user) {
      if (err) {
        return done(err);
      }
      if (!user) {
        return done(null, false, {
          message: 'Incorrect username.'
        });
      }
      return user.comparePassword(password, function(err, isMatch) {
        if (err) {
          return done(err);
        }
        if (isMatch) {
          return done(null, user);
        }
        return done(null, false, {
          message: 'Incorrect password.'
        });
      });
    });
  }));
};
