request = require 'supertest'
process.env.PORT = 3001
app = require '../../dist/app/app'

describe 'Server', ()->
  describe '#API', ()->
    it 'Should respond with hello world', (done)->
      request(app)
        .get('/api')
        .expect(200)
        .end (err, res)->
          expect(res.text).toEqual('Hello World')
          done()