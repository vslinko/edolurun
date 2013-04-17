symfio = require "symfio"

container = symfio "edolurun-server", __dirname

loader = container.get "loader"

loader.use require "symfio-contrib-express"
loader.use require "symfio-contrib-express-logger"
loader.use require "symfio-contrib-assets"

loader.use require "./plugins/receiver"
loader.use require "./plugins/commander"
loader.use require "./plugins/commander-socket"
loader.use require "./plugins/commander-express"
loader.use require "./plugins/help"
loader.use require "./plugins/mpd"

loader.load() if require.main is module
