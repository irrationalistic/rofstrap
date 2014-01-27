var app, express, http, path;

express = require('express');

http = require('http');

path = require('path');

app = module.exports = express();

require('./config/mongoose')(app);

require('./config/express')(app);

http.createServer(app).listen(app.get('port'), function() {
  return console.log('Express server listening on port ' + app.get('port'));
});
