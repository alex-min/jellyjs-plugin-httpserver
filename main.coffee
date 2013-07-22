express = require('express')
connected = false

module.exports = {
  load: (cb) ->
    @getSharedObjectManager().registerObject('httpserver', 'server', express())
    cb()
  oncall: (onj, params, cb) ->
    params.pluginParameters ?= {}
    params.pluginParameters.httpserver ?= {}
    params.pluginParameters.httpserver.port ?= 80

    app = @getSharedObjectManager().getObject('httpserver','server').getCurrentContent()
    app.listen(params.pluginParameters.httpserver.port) if connected == false
    @getLogger().info("Server listening on port #{params.pluginParameters.httpserver.port}")
    connected = true
    cb()
  unload: (cb) ->
    cb()
}
