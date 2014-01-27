var config;

config = {
  development: {
    env: 'development',
    dbURI: 'mongodb://localhost/rofstrap'
  },
  staging: {
    env: 'staging'
  },
  production: {
    env: 'production'
  }
};

module.exports = global.process.env.NODE_ENV ? config[global.process.env.NODE_ENV] : config.development;
