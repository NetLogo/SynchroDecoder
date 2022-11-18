import { Buffer } from 'buffer/index.js'

import PNG  from 'upng-js/UPNG.js'
import JPEG from 'jpeg-js/index.js'

dataURIToBytes = (uri) ->
  raw = window.atob(uri.slice(uri.indexOf(",") + 1))
  new Uint8Array(new ArrayBuffer(raw.length)).map((_, i) -> raw.charCodeAt(i))

aIsPrefixOfB = (a, b) ->
  for c, i in a
    if b[i] isnt c
      return false
  true

pngSignature = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
jpgSignature = [0xFF, 0xD8, 0xFF]

synchroDecoder =
  (b64) ->
    bytes = dataURIToBytes(b64)
    try

      if aIsPrefixOfB(pngSignature, bytes)

        image = PNG.decode(bytes)
        array = new Uint8ClampedArray(PNG.toRGBA8(image)[0])

        if array.length is (image.height * image.width * 4)
          { array, height: image.height, width: image.width, didSucceed: true }
        else
          throw new Error("Converted PNG bytes have length #{array.length}, but valid PNG bytes would have length #{image.height * image.width * 4}.")

      else if aIsPrefixOfB(jpgSignature, bytes)

        oldBuffer     = window.Buffer
        window.Buffer = Buffer
        image         = JPEG.decode(bytes)
        window.Buffer = oldBuffer
        array         = new Uint8ClampedArray(image.data)

        if array.length is (image.height * image.width * 4)
          { array, height: image.height, width: image.width, didSucceed: true }
        else
          throw new Error("Converted JPEG bytes have length #{array.length}, but valid JPEG bytes would have length #{image.height * image.width * 4}.")

      else
        throw new Error("Undecodable file type")

    catch ex
      { didSucceed: false }

synchroEncoder =
  # (ImageData) => String
  (image) ->
    png    = PNG.encode([image.data.buffer], image.width, image.height, 0)
    bytes  = new Uint8Array(png)
    chars  = Array.prototype.map.call(bytes, (b) -> String.fromCharCode(b) ).join("")
    base64 = btoa(chars)
    "data:image/png;base64,#{base64}"

export { synchroDecoder, synchroEncoder }
