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

extension RFC_9110.MediaType {
  /// Converges an RFC 2045 MIME `Content-Type` into an RFC 9110 HTTP
  /// media type.
  ///
  /// Total: every valid RFC 2045 Content-Type is representable as an
  /// RFC 9110 media type (RFC 9110 §8.3 adopts the MIME type/subtype
  /// registry). Parameter names lose their case-insensitive brand and
  /// travel as their raw spellings.
  public init(_ contentType: RFC_2045.ContentType) {
    self.init(
      contentType.type,
      contentType.subtype,
      parameters: Dictionary(
        uniqueKeysWithValues: contentType.parameters.map { (name, value) in
          (name.rawValue, value)
        }
      )
    )
  }
}
