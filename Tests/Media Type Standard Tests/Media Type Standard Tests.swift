import Media_Type_Standard
import RFC_2045
import RFC_9110
import Testing

@Suite
struct Test {
    @Suite
    struct Unit {
        @Test
        func `ContentType converges to MediaType`() throws {
            let contentType = try RFC_2045.ContentType("text/html; charset=UTF-8")
            let mediaType = RFC_9110.MediaType(contentType)
            #expect(mediaType.type == "text")
            #expect(mediaType.subtype == "html")
            #expect(mediaType.parameters["charset"] == "UTF-8")
        }

        @Test
        func `MediaType converges to ContentType`() throws {
            let mediaType = RFC_9110.MediaType("application", "json")
            let contentType = try RFC_2045.ContentType(mediaType)
            #expect(contentType.type == "application")
            #expect(contentType.subtype == "json")
            #expect(contentType.parameters.isEmpty)
        }

        @Test
        func `MediaType with parameter converges to ContentType`() throws {
            let mediaType = RFC_9110.MediaType(
                "multipart",
                "form-data",
                parameters: ["boundary": "abc123"]
            )
            let contentType = try RFC_2045.ContentType(mediaType)
            #expect(
                contentType.parameters[.boundary] == "abc123"
            )
        }
    }

    @Suite
    struct `Edge Case` {
        @Test
        func `invalid MediaType type rejects`() {
            let mediaType = RFC_9110.MediaType("", "plain")
            #expect(throws: RFC_2045.ContentType.Error.self) {
                try RFC_2045.ContentType(mediaType)
            }
        }

        @Test
        func `quoted parameter value survives`() throws {
            let mediaType = RFC_9110.MediaType(
                "multipart",
                "form-data",
                parameters: ["boundary": "with space"]
            )
            let contentType = try RFC_2045.ContentType(mediaType)
            #expect(
                contentType.parameters[.boundary] == "with space"
            )
        }
    }

    @Suite
    struct Integration {
        @Test
        func `round trip preserves identity`() throws {
            let original = try RFC_2045.ContentType("multipart/form-data; boundary=xYz-123")
            let roundTripped = try RFC_2045.ContentType(RFC_9110.MediaType(original))
            #expect(roundTripped == original)
        }
    }
}

extension Test {
    @Suite
    struct Extension {
        @Test
        func `a registered extension names its media type`() {
            #expect(RFC_9110.MediaType(extension: "pdf") == RFC_9110.MediaType("application", "pdf"))
            #expect(RFC_9110.MediaType(extension: "jpg") == RFC_9110.MediaType("image", "jpeg"))
            #expect(RFC_9110.MediaType(extension: "md") == RFC_9110.MediaType("text", "markdown"))
            #expect(RFC_9110.MediaType(extension: "eml") == RFC_9110.MediaType("message", "rfc822"))
            #expect(
                RFC_9110.MediaType(extension: "docx")
                    == RFC_9110.MediaType("application", "vnd.openxmlformats-officedocument.wordprocessingml.document")
            )
        }

        @Test
        func `an extension is compared without regard to case`() {
            #expect(RFC_9110.MediaType(extension: "PDF") == RFC_9110.MediaType("application", "pdf"))
            #expect(RFC_9110.MediaType(extension: "Html") == RFC_9110.MediaType("text", "html"))
        }

        @Test
        func `an extension no registration names has no media type`() {
            #expect(RFC_9110.MediaType(extension: "unknownextension") == nil)
            #expect(RFC_9110.MediaType(extension: "") == nil)
            #expect(RFC_9110.MediaType(extension: ".pdf") == nil)
        }
    }
}
