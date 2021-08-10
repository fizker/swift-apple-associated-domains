extension KeyedDecodingContainer {
	func decode<T: Decodable>(forKey key: Key) throws -> T {
		return try decode(T.self, forKey: key)
	}
}

extension AppleAppSiteAssociation.AppLinks.Details.Components {
	public init(from decoder: Decoder) throws {
		self = .init()

		let container = try decoder.container(keyedBy: CodingKeys.self)

		if container.contains(.path) {
			self.path = try container.decode(forKey: .path)
		}

		if container.contains(.query) {
			self.query = try container.decode(forKey: .query)
		}

		if container.contains(.fragment) {
			self.fragment = try container.decode(forKey: .fragment)
		}

		if container.contains(.isExcludingMatches) {
			self.isExcludingMatches = try container.decode(forKey: .isExcludingMatches)
		}

		if container.contains(.comment) {
			self.comment = try container.decode(forKey: .comment)
		}

		if container.contains(.isCaseSensitive) {
			self.isCaseSensitive = try container.decode(forKey: .isCaseSensitive)
		}

		if container.contains(.isPercentEncoded) {
			self.isPercentEncoded = try container.decode(forKey: .isPercentEncoded)
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		if path != "*" {
			try container.encode(path, forKey: .path)
		}

		if query != "*" {
			try container.encode(query, forKey: .query)
		}

		if fragment != "*" {
			try container.encode(fragment, forKey: .fragment)
		}

		if isExcludingMatches {
			try container.encode(isExcludingMatches, forKey: .isExcludingMatches)
		}

		if let comment = comment {
			try container.encode(comment, forKey: .comment)
		}

		if !isCaseSensitive {
			try container.encode(isCaseSensitive, forKey: .isCaseSensitive)
		}

		if !isPercentEncoded {
			try container.encode(isPercentEncoded, forKey: .isPercentEncoded)
		}
	}
}
