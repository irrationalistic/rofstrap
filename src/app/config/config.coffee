config =
  development:
    env: 'development'
    dbURI: 'mongodb://localhost/rofstrap'

  staging:
    env: 'staging'

  production:
    env: 'production'


module.exports = if global.process.env.NODE_ENV then config[global.process.env.NODE_ENV] else config.development