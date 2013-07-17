express = require('express')
app = express()
connected = false

module.exports = {
  load: (cb) ->
    @getSharedObjectManager().registerObject('httpserver', 'server', app)
    cb()
  oncall: (onj, params, cb) ->
    app.listen(params.port || 80) if connected == false
    connected = true
    cb()
  unload: (cb) ->
    cb()
}