User = require '../user'

module.exports = ()->
  # Seed a user
  user = new User
    username: 'test'
    password: 'test'
    email: 'test@test.com'

  console.log 'Seeding user'
  user.save (err)->
    if err and err.code is 11000
      console.log 'User already seeded!'
    else if err
      console.log err
    else
      console.log 'Added user: ' + user.username