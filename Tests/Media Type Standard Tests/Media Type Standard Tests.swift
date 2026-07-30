// ===----------------------------------------------------------------------===//
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// SPDX-License-Identifier: Apache-2.0
//
// ===----------------------------------------------------------------------===//

import Media_Type_Standard
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
        "multipart", "form-data", parameters: ["boundary": "abc123"])
      let contentType = try RFC_2045.ContentType(mediaType)
      #expect(contentType.parameters[RFC_2045.Parameter.Name(rawValue: "boundary")] == "abc123")
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
        "multipart", "form-data",
        parameters: ["boundary": "with space"]
      )
      let contentType = try RFC_2045.ContentType(mediaType)
      #expect(contentType.parameters[RFC_2045.Parameter.Name(rawValue: "boundary")] == "with space")
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
