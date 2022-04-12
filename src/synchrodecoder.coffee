import { Buffer } from 'buffer/index.js'

import PNG  from 'upng-js/UPNG.js'
import JPEG from 'jpeg-js/index.js'

dataURIToBytes = (uri) ->
  raw = window.atob(uri.slice(uri.indexOf(",") + 1))
  new Uint8Array(new ArrayBuffer(raw.length)).map((_, i) -> raw.charCodeAt(i))

synchroDecoder =
  (b64) ->
    bytes = dataURIToBytes(b64)
    try
      try
        image = PNG.decode(bytes)
        array = new Uint8ClampedArray(PNG.toRGBA8(image)[0])
        { array, height: image.height, width: image.width, didSucceed: true }
      catch ex
        if ex.includes("is not a PNG")

          oldBuffer     = window.Buffer
          window.Buffer = Buffer
          image         = JPEG.decode(bytes)
          window.Buffer = oldBuffer

          array = new Uint8ClampedArray(image.data)
          { array, height: image.height, width: image.width, didSucceed: true }

        else
          throw ex
    catch e
      { didSucceed: false }

export default synchroDecoder
