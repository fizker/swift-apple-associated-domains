extension AppleAppSiteAssociation.AppLinks {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self = .init(details: [])

		if container.contains(.details) {
			details = try container.decode(forKey: .details)
		}

		if container.contains(.defaults) {
			defaults = try container.decode(forKey: .defaults)
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(details, forKey: .details)

		if defaults != .init() {
			try container.encode(defaults, forKey: .defaults)
		}
	}
}
