symfio = require "symfio"

container = symfio "edolurun-client", __dirname

container.set "server", process.argv[2] or "127.0.0.1"

loader = container.get "loader"

loader.use require "./plugins/connector"
loader.use require "./plugins/mpd"

loader.load() if require.main is module
