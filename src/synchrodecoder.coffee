PNG  = require('upng-js')
JPEG = require('jpeg-js' )

dataURIToBytes = (uri) ->
  raw = window.atob(uri.slice(uri.indexOf(",") + 1))
  new Uint8Array(new ArrayBuffer(raw.length)).map((_, i) -> raw.charCodeAt(i))

window.synchroDecoder =
  (b64) ->
    bytes = dataURIToBytes(b64)
    try
      try
        image = PNG.decode(bytes)
        array = new Uint8ClampedArray(PNG.toRGBA8(image)[0])
        { array, height: image.height, width: image.width, didSucceed: true }
      catch ex
        if ex.includes("is not a PNG")
          image = JPEG.decode(bytes)
          array = new Uint8ClampedArray(image.data)
          { array, height: image.height, width: image.width, didSucceed: true }
        else
          throw ex
    catch e
      alert("Not a valid PNG or JPEG")
      { didSucceed: false }

module.exports = synchroDecoder
