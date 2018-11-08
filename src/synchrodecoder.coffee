PNG  = require('fast-png')
JPEG = require('jpeg-js' )

dataURIToBytes = (uri) ->
  raw = window.atob(uri.slice(uri.indexOf(",") + 1))
  new Uint8Array(new ArrayBuffer(raw.length)).map((_, i) -> raw.charCodeAt(i))

window.synchroDecoder =
  (b64) ->
    bytes = dataURIToBytes(b64)
    image =
      try
        try PNG.decode(bytes)
        catch ex
          if ex.message.includes("wrong PNG signature")
            JPEG.decode(bytes)
          else
            throw ex
      catch e
        alert("Not a valid PNG or JPEG")
    new ImageData(new Uint8ClampedArray(image.data), image.width, image.height)

module.exports = synchroDecoder
