var User;

User = require('../user');

module.exports = function() {
  var user;
  user = new User({
    username: 'test',
    password: 'test',
    email: 'test@test.com'
  });
  console.log('Seeding user');
  return user.save(function(err) {
    if (err && err.code === 11000) {
      return console.log('User already seeded!');
    } else if (err) {
      return console.log(err);
    } else {
      return console.log('Added user: ' + user.username);
    }
  });
};
