var app, express, http, path;

express = require('express');

http = require('http');

path = require('path');

console.log = (global.process.env.NODE_ENV != null) && global.process.env.NODE_ENV === 'production' ? function() {} : console.log;

app = module.exports = express();

require('./config/mongoose')(app);

require('./config/express')(app);

http.createServer(app).listen(app.get('port'), function() {
  return console.log('Express server listening on port ' + app.get('port'));
});
