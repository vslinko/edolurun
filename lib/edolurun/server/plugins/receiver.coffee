carrier = require "carrier"
net = require "net"


class Receiver extends net.Server
  constructor: ->
    @connections = {}

  listen: ->
    @on "connection", (connection) =>
      type = null

      messageListener = (message) =>
        if type
          @emit "message-#{type}", message, connection
        else
          type = message
          @connections[type] ||= []
          @connections[type].push connection

      carrier.carry connection, messageListener, "utf8", "\0"

      connection.on "close", =>
        if type
          @connections[type] = @connections[type].filter (savedConnection) ->
            connection isnt savedConnection

    net.Server::listen.apply @, arguments

  filterConnections: (type) ->
    if @connections[type] then @connections[type] else []

  sendMessage: (type, message) ->
    connections = @filterConnections type

    connections.forEach (connection) ->
      connection.write "#{message}\0"


module.exports = (container, callback) ->
  logger = container.get "logger"
  port = 34737

  logger.info "loading plugin", "receiver"

  receiver = new Receiver

  receiver.on "connection", (connection) ->
    remoteAddress = connection.remoteAddress

    logger.info "connected", remoteAddress, "receiver"

    connection.on "close", ->
      logger.info "disconnected", remoteAddress, "receiver"

  receiver.listen port, ->
    logger.info "listening", port, "receiver"
    callback()

  container.set "receiver", receiver
