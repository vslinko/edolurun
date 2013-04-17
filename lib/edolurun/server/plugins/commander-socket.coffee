carrier = require "carrier"
net = require "net"


module.exports = (container, callback) ->
  commander = container.get "commander"
  logger = container.get "logger"
  port = 34738

  logger.info "loading plugin", "commander-socket"

  server = new net.Server

  server.on "connection", (connection) ->
    connection.write "Welcome to Edolurun!\n"
    connection.write ">>> "
    carrier.carry connection, (message) ->
      commander.run message, (output) ->
        if output
          connection.write output + "\n"

        connection.write ">>> "

  server.listen port, ->
    logger.info "listening", port, "commander"
    callback()
