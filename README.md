# ExtraEncodable

A small Swift package that provides a single type, `ExtraEncodable`, allowing you to:

- encode additional data with an `Encodable` type
- omit some fields when encoding an `Encodable` type

## Usage

Add this package as a dependency to your `Package.swift`. 

### To encode extra data

```swift
let base = ... // some `Encodable`
let encodable = ExtraEncodable(base: foo, extraData: ["some": "data"])

// encode the encodable using any encoder
```

### To hide fields

```swift
let base = ... // some `Encodable`
let encodable = ExtraEncodable(base: foo, hiddenFields: ["foo"])

// encode the encodable using any encoder
```

Of course, it is also possible to combine `extraData` with `hiddenFields`.

## License (MIT)

Copyright 2018 Robbert Brandsma

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
