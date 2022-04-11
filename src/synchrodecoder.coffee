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
        arr   = new Uint8ClampedArray(PNG.toRGBA8(image)[0])
        new ImageData(arr, image.width, image.height)
      catch ex
        if ex.includes("is not a PNG")
          image = JPEG.decode(bytes)
          new ImageData(new Uint8ClampedArray(image.data), image.width, image.height)
        else
          throw ex
    catch e
      alert("Not a valid PNG or JPEG")

module.exports = synchroDecoder
