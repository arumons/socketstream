# Middleware: Asset Request Server
# --------------------------------
# Compiles and serves assets live in development mode (or whenever SS.config.pack_assets != true)

path = require('path')
util = require('util')
server = require('../utils.coffee')
assets = require('../asset')

module.exports = ->

  (request, response, next) ->

    if isValidRequest(request)
      file = urlToFile(request.ss.parsedURL)
      request.ss_benchmark_start = new Date
      try
        assets.compile[file.extension] file.name, (result) ->
          server.deliver(response, 200, result.content_type, result.output)
          benchmark_result = (new Date) - request.ss_benchmark_start
          SS.log.serve.compiled(file.name, benchmark_result)
      catch e
        server.showError(response, e)
        SS.log.error.exception(e)
    else
      next()


# PRIVATE

# Should we attempt to serve this request?
isValidRequest = (request) ->
  url = request.ss.parsedURL
  return false if url.initialDir == 'assets' # ignore pre-cached assets
  !url.extension || assets.supported_formats.include(url.extension)

# Parse incoming URL depending on file extension`
urlToFile = (url) ->
  if isValidScript(url)
    {name: "app/#{url.initialDir}/#{url.path}", extension: url.extension}
  else if url.extension
    {name: url.path, extension: url.extension}
  else
    rootHTML()

# Ensure script paths are re-written
isValidScript = (url) ->
  ['coffee', 'js'].include(url.extension)

# Decide which file to serve as the root
# Note: this synchronous request only runs in developer mode
rootHTML = ->
  jadeExists = path.existsSync "#{SS.root}/app/views/app.jade"
  if jadeExists
    {name: 'app.jade', extension: 'jade'}
  else
    {name: 'app.html', extension: 'html'}