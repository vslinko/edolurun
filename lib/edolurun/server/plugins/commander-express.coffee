module.exports = (container, callback) ->
  commander = container.get "commander"
  logger = container.get "logger"
  app = container.get "app"

  logger.info "loading plugin", "commander-express"

  app.post "/commander", (req, res) ->
    commander.run req.body.input, (output) ->
      res.send 200, output

  callback()
