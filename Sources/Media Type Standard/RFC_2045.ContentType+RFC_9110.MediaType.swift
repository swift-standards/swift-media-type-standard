public import RFC_2045
import RFC_2045_Coder
public import RFC_9110

extension RFC_2045.ContentType {

    public init(_ mediaType: RFC_9110.MediaType) throws(RFC_2045.ContentType.Error) {
        var parameters: [RFC_2045.Parameter.Name: String] = [:]
        for (name, value) in mediaType.parameters {
            let parameterName: RFC_2045.Parameter.Name
            do throws(RFC_2045.Parameter.Name.Error) {
                parameterName = try RFC_2045.Parameter.Name(name)
            } catch {
                throw .invalidParameter(name, reason: error.description)
            }
            guard parameters.updateValue(value, forKey: parameterName) == nil else {
                throw .invalidParameter(name, reason: "parameter name is repeated")
            }
        }
        let candidate = RFC_2045.ContentType(
            __unchecked: (),
            type: mediaType.type,
            subtype: mediaType.subtype,
            parameters: parameters
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
