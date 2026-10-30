public import RFC_9110

extension RFC_9110.MediaType {
    /// The media type whose registration names `extension` as its file extension, compared without regard to case and
    /// given without its dot; nil for an extension no registration below names.
    public init?(extension name: String) {
        guard let registered = Self.registered[name.lowercased()] else { return nil }
        self.init(registered.type, registered.subtype)
    }

    /// File extensions and the media type each names, as the IANA media type registrations give them in their
    /// "File extension(s)" field (or the RFC that registers the type).
    static let registered: [String: (type: String, subtype: String)] = [
        "pdf": ("application", "pdf"),
        "json": ("application", "json"),
        "xml": ("application", "xml"),
        "zip": ("application", "zip"),
        "gz": ("application", "gzip"),
        "rtf": ("application", "rtf"),
        "doc": ("application", "msword"),
        "xls": ("application", "vnd.ms-excel"),
        "ppt": ("application", "vnd.ms-powerpoint"),
        "docx": ("application", "vnd.openxmlformats-officedocument.wordprocessingml.document"),
        "xlsx": ("application", "vnd.openxmlformats-officedocument.spreadsheetml.sheet"),
        "pptx": ("application", "vnd.openxmlformats-officedocument.presentationml.presentation"),
        "odt": ("application", "vnd.oasis.opendocument.text"),
        "ods": ("application", "vnd.oasis.opendocument.spreadsheet"),
        "odp": ("application", "vnd.oasis.opendocument.presentation"),
        "jpg": ("image", "jpeg"),
        "jpeg": ("image", "jpeg"),
        "jpe": ("image", "jpeg"),
        "png": ("image", "png"),
        "gif": ("image", "gif"),
        "tif": ("image", "tiff"),
        "tiff": ("image", "tiff"),
        "bmp": ("image", "bmp"),
        "webp": ("image", "webp"),
        "svg": ("image", "svg+xml"),
        "heic": ("image", "heic"),
        "heif": ("image", "heif"),
        "txt": ("text", "plain"),
        "text": ("text", "plain"),
        "csv": ("text", "csv"),
        "htm": ("text", "html"),
        "html": ("text", "html"),
        "md": ("text", "markdown"),
        "markdown": ("text", "markdown"),
        "ics": ("text", "calendar"),
        "vcf": ("text", "vcard"),
        "eml": ("message", "rfc822"),
        "mp3": ("audio", "mpeg"),
        "m4a": ("audio", "mp4"),
        "wav": ("audio", "wav"),
        "mp4": ("video", "mp4"),
        "mov": ("video", "quicktime"),
    ]
}
