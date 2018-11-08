# SynchroDecoder

## What Is It?

SynchroDecoder is a JavaScript library for decoding images to `ImageData` synchronously.  Generally, synchronous image decoding should be avoided, but, for some uses cases, it **must** happen synchronously, and the standard JavaScript approaches (e.g. setting an `Image`'s `src`) don't allow for synchrony.

This library currently only supports JPEGs and PNGs.  It probably has all manner of problems.  If synchrony is not absolutely required for your use case, we strongly recommend seeking a different solution than this library.  This library is *only* for those *desperate* for synchrony.

## Example

```javascript
const jpeg64    = "data:image/jpeg;base64,..."
const imageData = window.synchroDecoder(jpeg64);
document.getElementById('canvy').getContext('2d').putImageData(imageData, 0, 0);
```

(Yeah, we shouldn't just dump `synchroDecoder` onto `window`, but it's good enough for now.)

## Terms of Use

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png)](http://creativecommons.org/publicdomain/zero/1.0/)

SynchroDecoder is in the public domain.  To the extent possible under law, Uri Wilensky has waived all copyright and related or neighboring rights.
