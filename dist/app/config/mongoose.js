var config, mongoose;

mongoose = require('mongoose');

config = require('./config');

module.exports = function(app) {
  var db;
  mongoose.connect(config.dbURI);
  db = mongoose.connection;
  db.on('error', console.error.bind(console, 'connection error'));
  if (config.env === 'development') {
    return db.once('open', function() {
      var seedPath;
      seedPath = require('path').join(__dirname, '../models/seeds/');
      return require("fs").readdirSync(seedPath).forEach(function(file) {
        return require(seedPath + file)();
      });
    });
  }
};
