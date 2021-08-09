import XCTest
import AppleAppSiteAssociation

final class WebCredentials_Tests: XCTestCase {
	typealias WebCredentials = AppleAppSiteAssociation.WebCredentials

	func test__initWithStringLiteral__anyString__initsWithSingleApp() throws {
		let expected = WebCredentials(apps: [ "foo" ])
		let actual: WebCredentials = "foo"

		XCTAssertEqual(expected, actual)
		XCTAssertEqual([ "foo" ], actual.apps)
	}

	func test__initWithArrayLiteral__anyNumberOfStrings__initsWithRequestedApps() throws {
		let expected = WebCredentials(apps: [ "foo", "bar" ])
		let actual: WebCredentials = [ "foo", "bar" ]

		XCTAssertEqual(expected, actual)
		XCTAssertEqual([ "foo", "bar" ], actual.apps)
	}
}
