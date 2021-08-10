// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AppleAssociatedDomains",
	products: [
		.library(
			name: "AppleAssociatedDomains",
			targets: ["AppleAssociatedDomains"]
		),
	],
	targets: [
		.target(
			name: "AppleAssociatedDomains",
			dependencies: []
		),
		.testTarget(
			name: "AppleAssociatedDomainsTests",
			dependencies: ["AppleAssociatedDomains"]
		),
	]
)
