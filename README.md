# swift-apple-associated-domains

JSON model for creating or parsing [Apple´s Associated Domains specification][AAD].

## Usage

### Declare SwiftPM dependency with release tag

Add this repository to the Package.swift manifest of your project:

```
// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "MyTool",
  dependencies: [
    .package(url: "https://github.com/fizker/swift-apple-associated-domains.git", .upToNextMajor(from: "1.0")),
  ],
  targets: [
    .target(name: "MyTarget", dependencies: [
      .product(name: "AppleAssociatedDomains", package: "swift-apple-associated-domains"),
    ]),
  ]
)
```

### Create the specification

Note: This is the sample from https://developer.apple.com/documentation/Xcode/supporting-associated-domains#Add-the-Associated-Domain-File-to-Your-Website
```
import AppleAssociatedDomains

let spec = AppleAppSiteAssociation(
	applinks: .init(details: [
		.init(
			appIDs: [ "ABCDE12345.com.example.app", "ABCDE12345.com.example.app2" ],
			components: [
				.init(
					fragment: "no_universal_links",
					isExcludingMatches: true,
					comment: "Matches any URL whose fragment equals no_universal_links and instructs the system not to open it as a universal link"
				),
				.init(
					path: "/buy/*",
					comment: "Matches any URL whose path starts with /buy/"
				),
				.init(
					path: "/help/website/*",
					isExcludingMatches: true,
					comment: "Matches any URL whose path starts with /help/website/ and instructs the system not to open it as a universal link"
				),
				.init(
					path: "/help/*",
					query: [ "articleNumber": "????" ],
					comment: "Matches any URL whose path starts with /help/ and which has a query item with name 'articleNumber' and a value of exactly 4 characters"
				),
			]
		),
	]),
	appclips: ["ABCED12345.com.example.MyApp.Clip"],
	webcredentials: [ "ABCDE12345.com.example.app" ]
)
```

### Serve the file

The file needs to served from `/.well-known/apple-app-site-association`. This value is also exposed on the  `AppleAppSiteAssociation` object:

The `AppleAppSiteAssociation` object conforms to `Codable`, making it trivial to convert to JSON.

```
assert(spec.serverPath == "/.well-known/apple-app-site-association")
let json = try jsonEncoder.encode(spec)
server.get(path: spec.serverPath, content: json)
```

[AAD]: https://developer.apple.com/documentation/Xcode/supporting-associated-domains
