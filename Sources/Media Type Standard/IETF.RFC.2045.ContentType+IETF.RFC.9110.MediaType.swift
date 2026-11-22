public import RFC_2045
public import RFC_9110

extension IETF.RFC.`2045`.ContentType {

    public init(_ mediaType: IETF.RFC.`9110`.MediaType) throws(IETF.RFC.`2045`.ContentType.Error) {
        var parameters: [IETF.RFC.`2045`.Parameter.Name: String] = [:]
        for (name, value) in mediaType.parameters {
            let parameterName: IETF.RFC.`2045`.Parameter.Name
            do throws(IETF.RFC.`2045`.Parameter.Name.Error) {
                parameterName = try IETF.RFC.`2045`.Parameter.Name(name)
            } catch {
                throw .invalidParameter(name, reason: error.description)
            }
            guard parameters.updateValue(value, forKey: parameterName) == nil else {
                throw .invalidParameter(name, reason: "parameter name is repeated")
            }
        }
        let candidate = IETF.RFC.`2045`.ContentType(
            __unchecked: (),
            type: mediaType.type,
            subtype: mediaType.subtype,
            parameters: parameters
        )
        let parsed = try IETF.RFC.`2045`.ContentType(candidate.rawValue)
        guard parsed == candidate else {
            throw .invalidParameter(
                candidate.rawValue,
                reason: "media type does not survive the RFC 2045 canonical round trip"
            )
        }
        self = parsed
    }
}
