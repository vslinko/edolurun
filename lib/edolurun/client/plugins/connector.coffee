carrier = require "carrier"
net = require "net"


module.exports = (container, callback) ->
  logger = container.get "logger"

  logger.info "loading plugin", "connector"

  container.set "connector", (address, name, callback) ->
    connection = new net.Socket

    connection.connect 34737, address

    connection.on "connect", ->
      @write "#{name}\0", ->
        callback connection

      messageListener = (message) =>
        args = message.split " "
        args[0] = "#{args[0]} command"
        connection.emit.apply connection, args

      carrier.carry connection, messageListener, "utf8", "\0"

  callback()
