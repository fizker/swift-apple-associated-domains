public struct AppleAppSiteAssociation : Codable, Equatable {
	/// The root object for a universal links service definition.
	///
	/// Use this object to define the universal links you want to associate with your domain. Add the JSON code to your apple-app-site-association file along with the app identifiers for the apps that you designate to handle universal links for your domain.
	public struct AppLinks : Codable, Equatable {
		/// A list of apps and the universal links they handle for a domain.
		///
		/// All keys in the details object are optional.
		///
		/// Use appIDs to specify the apps that can access the specific URLs you define in the associated components array. You specify the application identifiers in the following format:
		/// ```
		/// <Application Identifier Prefix>.<Bundle Identifier>
		/// ```
		public struct Details : Codable, Equatable {
			/// Patterns that define the universal links an app can open.
			///
			/// Use this object to define whether an associated app can open specific URLs in this domain as universal links. The order that you use to specify the patterns in the array determines the order the system follows when looking for a match. The first match wins, allowing you to designate one app to handle specified URLs in your website, and another app to handle the rest.
			///
			/// You can also use the following wildcards in your URL pattern-matching definitions:
			/// - * — Matches zero or more characters. This performs a greedy match and matches as many characters as possible.
			/// - ? — Matches any single character.
			///
			/// In addition, you can use ?* to match one or more characters (that is, at least one character).
			///
			/// A match occurs when a URL matches all the components that a components object specifies.
			public struct Components : Codable, Equatable {
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
					case isExcludingMatches = "exclude"
					case comment
					case isCaseSensitive = "caseSensitive"
					case isPercentEncoded = "percentEncoded"
				}

				/// The pattern to match with the URL path component. The default is *, which matches everything.
				public var path: String = "*"

				/// The pattern or dictionary to match with the URL query component. The default is *, which matches everything.
				public var query: Query = .single("*")

				/// The pattern to match with the URL fragment component. The default is *, which matches everything.
				public var fragment: String = "*"

				/// A Boolean value that indicates whether to stop pattern matching and prevent the universal link from opening if the URL matches the associated pattern. The default is false.
				public var isExcludingMatches: Bool = false

				/// Text that the system ignores. Use this to provide information about the URLs a pattern matches.
				public var comment: String?

				/// A Boolean value that indicates whether pattern matching is case-sensitive. The default is true.
				public var isCaseSensitive: Bool = true

				/// A Boolean value that indicates whether URLs are percent-encoded. The default is true.
				public var isPercentEncoded: Bool = true

				public init(
					path: String = "*",
					query: Query = .single("*"),
					fragment: String = "*",
					isExcludingMatches: Bool = false,
					comment: String? = nil,
					isCaseSensitive: Bool = true,
					isPercentEncoded: Bool = true
				) {
					self.path = path
					self.query = query
					self.fragment = fragment
					self.isExcludingMatches = isExcludingMatches
					self.comment = comment
					self.isCaseSensitive = isCaseSensitive
					self.isPercentEncoded = isPercentEncoded
				}
			}

			/// An array of application identifiers that specify the apps that can handle the universal links in the components array.
			public var appIDs: [String]

			/// A dictionary for defining the default settings to use for all universal links pattern matching in the components array.
			public var defaults: Components = .init()

			/// An array of components that define the universal link URLs an app can handle.
			public var components: [Components] = []

			enum CodingKeys: String, CodingKey {
				case defaults, components, appIDs
			}

			public init(
				appIDs: [String],
				defaults: Components = .init(),
				components: [Components] = []
			) {
				self.appIDs = appIDs
				self.defaults = defaults
				self.components = components
			}
		}

		enum CodingKeys: String, CodingKey {
			case defaults, details
		}

		/// The global pattern-matching settings to use as defaults for all universal links in the domain.
		public var defaults: Details.Components

		/// An array of Details objects that define the apps and the universal links they handle for the domain.
		public var details: [Details]

		public init(details: [Details], defaults: Details.Components = .init()) {
			self.details = details
			self.defaults = defaults
		}
	}

	public struct WebCredentials : Codable, Equatable {
		public var apps: [String]

		public init(apps: [String]) {
			self.apps = apps
		}
	}

	public struct AppClips : Codable, Equatable {
		public var apps: [String]

		public init(apps: [String]) {
			self.apps = apps
		}
	}

	public static let serverPath = "/.well-known/apple-app-site-association"
	public var serverPath: String { Self.serverPath }

	public var applinks: AppLinks?
	public var appclips: AppClips
	public var webcredentials: WebCredentials

	public init(applinks: AppLinks? = nil, appclips: AppClips = .init(apps: []), webcredentials: WebCredentials = .init(apps: [])) {
		self.applinks = applinks
		self.appclips = appclips
		self.webcredentials = webcredentials
	}

	enum CodingKeys: String, CodingKey {
		case applinks, appclips, webcredentials
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		if applinks != nil {
			try container.encode(applinks, forKey: .applinks)
		}

		if !appclips.apps.isEmpty {
			try container.encode(appclips, forKey: .appclips)
		}

		if !webcredentials.apps.isEmpty {
			try container.encode(webcredentials, forKey: .webcredentials)
		}
	}
}

extension AppleAppSiteAssociation.AppLinks.Details.Components.Query: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self = .single(value)
	}
}
extension AppleAppSiteAssociation.AppLinks.Details.Components.Query: ExpressibleByDictionaryLiteral {
	public init(dictionaryLiteral elements: (String, String)...) {
		self = .multiple([String : String](uniqueKeysWithValues: elements))
	}
}

extension AppleAppSiteAssociation.AppClips: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(apps: [ value ])
	}
}
extension AppleAppSiteAssociation.AppClips: ExpressibleByArrayLiteral {
	public init(arrayLiteral elements: String...) {
		self.init(apps: elements)
	}
}

extension AppleAppSiteAssociation.WebCredentials: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(apps: [ value ])
	}
}
extension AppleAppSiteAssociation.WebCredentials: ExpressibleByArrayLiteral {
	public init(arrayLiteral elements: String...) {
		self.init(apps: elements)
	}
}
