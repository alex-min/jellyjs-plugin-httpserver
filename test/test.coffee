pluginDir = __dirname + '/../'
toType = (obj) -> ({}).toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()
assert = require('chai').assert;
request = require('request')

try
  jy = require('jellyjs')
catch e
  root = __dirname + '/../../../../';
  jy = require("#{root}/index.js");

describe('#Plugin::httpserver', ->
  it('Should load the plugin', (cb) ->
    jelly = new jy.Jelly()
    jelly.getPluginDirectoryList().readPluginFromPath(pluginDir, 'httpserver', (err, dt) ->
      cb(err)
    )
  )

  it('Should register an express server', (cb) ->
    jelly = new jy.Jelly()
    jelly.getPluginDirectoryList().readPluginFromPath(pluginDir, 'httpserver', (err, dt) ->
      if err?
        cb(err); cb = ->
        return
      dt.getPluginInterface().load((err) ->
        if err?
          cb(err); cb = ->
          return
        try
          server = dt.getPluginInterface().getSharedObjectManager().getObject('httpserver', 'server')
          assert.equal(toType(server), 'object')
          assert.equal(server.constructor.name, 'SharedObject')
          port = parseInt(Math.random() * 2000) + 2000
          dt.getPluginInterface().oncall({}, {pluginParameters:{httpserver:{port:port}}}, (err) ->
            request("http://127.0.0.1:#{port}", (err, response, body) ->
              console.log("Server is responding successfully on port #{port}")
              cb(err)
            )
          )
        catch e
          cb(e)
      )
    )
  )
)