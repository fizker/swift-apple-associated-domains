public struct AppleAppSiteAssociation : Codable, Equatable {
	public struct AppLinks : Codable, Equatable {
		public struct Details : Codable, Equatable {
			public struct Component : Codable, Equatable {
				public enum Query: Codable, Equatable {
					case single(String)
					case multiple([String: String])

					public func encode(to encoder: Encoder) throws {
						var container = encoder.singleValueContainer()
						switch self {
						case let .single(pattern):
							try container.encode(pattern)
						case let .multiple(patterns):
							try container.encode(patterns)
						}
					}

					public init(from decoder: Decoder) throws {
						let container = try decoder.singleValueContainer()
						do {
							let singleValue = try container.decode(String.self)
							self = .single(singleValue)
						} catch {
							let dict = try container.decode([String: String].self)
							self = .multiple(dict)
						}
					}
				}

				enum CodingKeys: String, CodingKey {
					case path = "/"
					case query = "?"
					case fragment = "#"
					case exclude
					case comment
					case caseSensitive
					case percentEncoded
				}

				/// The pattern to match with the URL path component. The default is *, which matches everything.
				public var path: String = "*"

				/// The pattern or dictionary to match with the URL query component. The default is *, which matches everything.
				public var query: Query = .single("*")

				/// The pattern to match with the URL fragment component. The default is *, which matches everything.
				public var fragment: String = "*"

				/// A Boolean value that indicates whether to stop pattern matching and prevent the universal link from opening if the URL matches the associated pattern. The default is false.
				public var exclude: Bool = false

				/// Text that the system ignores. Use this to provide information about the URLs a pattern matches.
				public var comment: String?

				/// A Boolean value that indicates whether pattern matching is case-sensitive. The default is true.
				public var caseSensitive: Bool = true

				/// A Boolean value that indicates whether URLs are percent-encoded. The default is true.
				public var percentEncoded: Bool = true
			}

			public var appIDs: [String]
			public var defaults: Component = .init()
			public var components: [Component] = []
		}

		public var defaults: Details.Component = .init()
		public var details: [Details]
	}

	public var applinks: AppLinks?
}

extension AppleAppSiteAssociation.AppLinks.Details.Component.Query: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self = .single(value)
	}
}
extension AppleAppSiteAssociation.AppLinks.Details.Component.Query: ExpressibleByDictionaryLiteral {
	public init(dictionaryLiteral elements: (String, String)...) {
		self = .multiple([String : String](uniqueKeysWithValues: elements))
	}
}
