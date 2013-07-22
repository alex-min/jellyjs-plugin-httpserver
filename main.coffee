express = require('express')

module.exports = {
  load: (cb) ->
    @getSharedObjectManager().registerObject('httpserver', 'server', express())
    cb()
  oncall: (onj, params, cb) ->
    try
      params.pluginParameters ?= {}
      params.pluginParameters.httpserver ?= {}
      params.pluginParameters.httpserver.port ?= 80

      app = @getSharedObjectManager().getObject('httpserver','server').getCurrentContent()
      app.listen(params.pluginParameters.httpserver.port)
      @getLogger().info("Server listening on port #{params.pluginParameters.httpserver.port}")
      cb()
    catch e
      cb(e)
  unload: (cb) ->
    cb()
}
