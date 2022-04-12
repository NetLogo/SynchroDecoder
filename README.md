# SynchroDecoder

## What Is It?

SynchroDecoder is a JavaScript library for decoding images to binary data synchronously.  Generally, synchronous image decoding should be avoided, but, for some use cases, it **must** happen synchronously, and the standard JavaScript approaches (e.g. setting an `Image`'s `src`) don't allow for synchrony.

This library currently only supports JPEGs and PNGs.  If synchrony is not absolutely required for your use case, we strongly recommend seeking a different solution than this library.  This library is *only* for those *desperate* for synchrony.

## Example

```javascript
import synchroDecoder from 'path_to/synchrodecoder.mjs';

const jpeg64 = "data:image/jpeg;base64,..."

const { array, height, width, didSucceed } = synchroDecoder(jpeg64);

if (didSucceed) {
  const imageData = new ImageData(array, width, height);
  document.getElementById('canvy').getContext('2d').putImageData(imageData, 0, 0);
} else {
  alert("Error when decoding!");
}
```

## Terms of Use

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png)](http://creativecommons.org/publicdomain/zero/1.0/)

SynchroDecoder is in the public domain.  To the extent possible under law, Uri Wilensky has waived all copyright and related or neighboring rights.
