class Commander
  constructor: ->
    @descriptions = {}
    @commands = {}

  run: (input, callback) ->
    return callback() if input.length == 0

    args = input.split " "
    name = args.shift()

    if @commands[name]
      @commands[name] args, callback
    else
      callback "Command `#{name}' not found"

  register: (name, description, command) ->
    @descriptions[name] = description
    @commands[name] = command


module.exports = (container, callback) ->
  logger = container.get "logger"

  logger.info "loading plugin", "commander"

  container.set "commander", new Commander

  callback()
