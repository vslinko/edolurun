module.exports = (container, callback) ->
  commander = container.get "commander"
  receiver = container.get "receiver"
  logger = container.get "logger"

  logger.info "loading plugin", "mpd"

  commander.register "mpd-connections", "list all MPD connections",
    (args, callback) ->
      connections = receiver.filterConnections "mpd"

      addresses = connections.map (connection) ->
        connection.remoteAddress

      callback addresses.join "\n"

  commander.register "mpd-play", "play audio on all MPD connections",
    (args, callback) ->
      receiver.sendMessage "mpd", "play"
      callback()

  commander.register "mpd-stop", "stop audio on all MPD connections",
    (args, callback) ->
      receiver.sendMessage "mpd", "stop"
      callback()

  callback()
