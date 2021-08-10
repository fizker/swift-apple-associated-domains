import XCTest
import AppleAppSiteAssociation

final class AppleAppSiteAssociation_AppLink_Details_Components_Query_Tests: XCTestCase {
	typealias Query = AppleAppSiteAssociation.AppLinks.Details.Components.Query

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

	func test__encode__bothValues__encodesCorrectly() throws {
		let single: Query = .single("foo")
		let multiple: Query = .multiple([ "foo": "123", "bar": "456" ])

		XCTAssertEqual(try encodeToString(single), #""foo""#)
		XCTAssertEqual(try encodeToString(multiple), """
			{
			  "bar" : "456",
			  "foo" : "123"
			}
			"""
		)
	}

	func test__decode__bothValues__decodesCorrectly() throws {
		let single: Query = try decodeFromString(#""foo""#)
		let multiple: Query = try decodeFromString(#"{"bar":"456","foo":"123"}"#)

		XCTAssertEqual(single, .single("foo"))
		XCTAssertEqual(multiple, .multiple([ "foo": "123", "bar": "456" ]))
	}
}
