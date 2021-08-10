import XCTest
import AppleAppSiteAssociation

final class AppleAppSiteAssociationTests: XCTestCase {
	func test__encode__empty__encodesCorrectly() throws {
		let value = AppleAppSiteAssociation()

		let actual = try encodeToString(value)
		let expected = """
			{

			}
			"""

		XCTAssertEqual(actual, expected)
	}
}
