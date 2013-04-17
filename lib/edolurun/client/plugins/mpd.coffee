komponist = require "komponist"


module.exports = (container, callback) ->
  connector = container.get "connector"
  server = container.get "server"
  logger = container.get "logger"

  logger.info "loading plugin", "mpd"

  client = komponist.createConnection 6600, "127.0.0.1"

  client.on "ready", ->
    connector server, "mpd", (connection) ->
      logger.info "connected", server, "mpd"

      connection.on "play command", ->
        client.play()

      connection.on "stop command", ->
        client.stop()

      callback()
