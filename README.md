# Media Type Standard

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Bridges the RFC 2045 `Content-Type` and RFC 9110 media-type representations in Swift — converts between the two spec vocabularies so a value expressed in one is usable as the other. Foundation-free.

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-media-type-standard.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Media Type Standard", package: "swift-media-type-standard")
    ]
)
```

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
