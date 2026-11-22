public import RFC_2045
public import RFC_9110

extension IETF.RFC.`9110`.MediaType {

    public init(_ contentType: IETF.RFC.`2045`.ContentType) {
        self.init(
            contentType.type,
            contentType.subtype,
            parameters: Dictionary(
                uniqueKeysWithValues: contentType.parameters.map { name, value in
                    (name.rawValue, value)
                }
            )
        )
    }
}
