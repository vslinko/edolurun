module.exports = (container, callback) ->
  commander = container.get "commander"
  logger = container.get "logger"

  logger.info "loading plugin", "help"

  commander.register "help", "print this help", (args, callback) ->
    output = []

    for command, description of commander.descriptions
      output.push "#{command}: #{description}"

    callback output.join "\n"

  callback()
