import XCTest
import AppleAppSiteAssociation

final class AppleAppSiteAssociation_AppLink_Details_Component_Query_Tests: XCTestCase {
	typealias Query = AppleAppSiteAssociation.AppLinks.Details.Component.Query

	func test__initWithStringLiteral__anyString__expectedValueInitialised() throws {
		let expected: Query = .single("foo")
		let actual: Query = "foo"

		XCTAssertEqual(expected, actual)
	}

	func test__initWithDictionaryLiteral__multipleStrings__expectedValueInitialised() throws {
		let expected: Query = .multiple([
			"foo": "123",
			"bar": "456",
		])
		let actual: Query = [
			"foo": "123",
			"bar": "456",
		]

		XCTAssertEqual(expected, actual)
	}
}
