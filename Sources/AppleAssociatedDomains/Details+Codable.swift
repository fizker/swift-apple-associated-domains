extension AppleAppSiteAssociation.AppLinks.Details {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self = .init(appIDs: [])

		if container.contains(.appIDs) {
			self.appIDs = try container.decode(forKey: .appIDs)
		}

		if container.contains(.components) {
			self.components = try container.decode(forKey: .components)
		}

		if container.contains(.defaults) {
			self.defaults = try container.decode(forKey: .defaults)
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(appIDs, forKey: .appIDs)

		if defaults != .init() {
			try container.encode(defaults, forKey: .defaults)
		}

		if !components.isEmpty {
			try container.encode(components, forKey: .components)
		}
	}
}
