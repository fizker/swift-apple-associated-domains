import XCTest
import AppleAppSiteAssociation

final class AppClips_Tests: XCTestCase {
	typealias AppClips = AppleAppSiteAssociation.AppClips

	func test__initWithStringLiteral__anyString__initsWithSingleApp() throws {
		let expected = AppClips(apps: [ "foo" ])
		let actual: AppClips = "foo"

		XCTAssertEqual(expected, actual)
		XCTAssertEqual([ "foo" ], actual.apps)
	}

	func test__initWithArrayLiteral__anyNumberOfStrings__initsWithRequestedApps() throws {
		let expected = AppClips(apps: [ "foo", "bar" ])
		let actual: AppClips = [ "foo", "bar" ]

		XCTAssertEqual(expected, actual)
		XCTAssertEqual([ "foo", "bar" ], actual.apps)
	}
}
