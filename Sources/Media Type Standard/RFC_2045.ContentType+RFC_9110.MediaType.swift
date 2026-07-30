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

public import RFC_2045
public import RFC_9110

extension RFC_2045.ContentType {
  /// Converges an RFC 9110 HTTP media type into an RFC 2045 MIME
  /// `Content-Type`, validating against the RFC 2045 grammar.
  ///
  /// Partial: RFC 9110 media types carry unvalidated `String` fields, so
  /// the conversion re-validates through the RFC 2045 canonical
  /// serializer-then-parser round trip (quoted-string handling for
  /// non-token parameter values comes from the canonical serializer).
  public init(_ mediaType: RFC_9110.MediaType) throws(RFC_2045.ContentType.Error) {
    let candidate = RFC_2045.ContentType(
      __unchecked: (),
      type: mediaType.type,
      subtype: mediaType.subtype,
      parameters: Dictionary(
        uniqueKeysWithValues: mediaType.parameters.map { (name, value) in
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
