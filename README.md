# swift-media-type-standard

Use this package when a media type crosses between HTTP and MIME, so you hold an `RFC_9110.MediaType` and need an `RFC_2045.ContentType`, or the other way round. It also looks up the media type for a file extension with `RFC_9110.MediaType.init(extension:)`. It re-exports both modules. If you only work on one side, use swift-rfc-9110 or swift-rfc-2045 directly.

## Laws

- Going from `RFC_2045.ContentType` to `RFC_9110.MediaType` never fails. Converting back gives an equal content type.
- Going from `RFC_9110.MediaType` to `RFC_2045.ContentType` throws when a parameter name is not valid under RFC 2045, when two parameter names become the same RFC 2045 name, or when the result does not read back as the same value under RFC 2045. An empty type or subtype is refused this way.
- Parameter values that need quoting, such as a boundary with a space, come through unchanged.
- `RFC_9110.MediaType.init(extension:)` ignores case and expects the extension without its dot, so `.pdf` gives nil. It knows only a fixed list of common extensions taken from the IANA registrations, and returns nil for any other.
- The extension lookup returns a media type without parameters. A text type such as `text/html` has no charset.
