var app, express, http, path, port;

express = require('express');

http = require('http');

path = require('path');

console.log = (global.process.env.NODE_ENV != null) && global.process.env.NODE_ENV === 'production' ? function() {} : console.log;

app = module.exports = express();

require('./config/mongoose')(app);

require('./config/express')(app);

port = app.get('port');

http.createServer(app).listen(port, function() {
  return console.log("Express server listening on port " + port);
});
