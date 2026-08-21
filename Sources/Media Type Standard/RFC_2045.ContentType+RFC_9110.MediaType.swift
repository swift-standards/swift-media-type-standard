public import RFC_2045
public import RFC_9110

extension RFC_2045.ContentType {

    public init(_ mediaType: RFC_9110.MediaType) throws(RFC_2045.ContentType.Error) {
        let candidate = RFC_2045.ContentType(
            __unchecked: (),
            type: mediaType.type,
            subtype: mediaType.subtype,
            parameters: Dictionary(
                uniqueKeysWithValues: mediaType.parameters.map { name, value in
                    (RFC_2045.Parameter.Name(rawValue: name), value)
                }
            )
        )
        let parsed = try RFC_2045.ContentType(candidate.rawValue)
        guard parsed == candidate else {
            throw .invalidParameter(
                candidate.rawValue,
                reason: "media type does not survive the RFC 2045 canonical round trip"
            )
        }
        self = parsed
    }
}
