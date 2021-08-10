import XCTest
import AppleAppSiteAssociation

final class ComponentsTests: XCTestCase {
	typealias Components = AppleAppSiteAssociation.AppLinks.Details.Components

	func test__decode__minObject_defaultValue__decodesCorrectly() throws {
		let json = """
			{

			}
			"""

		let actual: Components = try decodeFromString(json)
		let expected = Components()

		XCTAssertEqual(actual, expected)
	}

	func test__decode__fullObject__decodesCorrectly() throws {
		let json = """
			{
			  "?" : {
			    "some" : "query"
			  },
			  "/" : "/some/path",
			  "#" : "some-fragment",
			  "caseSensitive" : false,
			  "comment" : "Some comment",
			  "exclude" : true,
			  "percentEncoded" : false
			}
			"""

		let actual: Components = try decodeFromString(json)
		let expected = Components(
			path: "/some/path",
			query: [ "some": "query" ],
			fragment: "some-fragment",
			isExcludingMatches: true,
			comment: "Some comment",
			isCaseSensitive: false,
			isPercentEncoded: false
		)

		XCTAssertEqual(expected, actual)
	}

	func test__encode__fullObject_nonDefaultValue__encodesCorrectly() throws {
		let value = Components(
			path: "/some/path",
			query: [ "some": "query" ],
			fragment: "some-fragment",
			isExcludingMatches: true,
			comment: "Some comment",
			isCaseSensitive: false,
			isPercentEncoded: false
		)

		let actual = try encodeToString(value)
		let expected = """
			{
			  "?" : {
			    "some" : "query"
			  },
			  "/" : "/some/path",
			  "#" : "some-fragment",
			  "caseSensitive" : false,
			  "comment" : "Some comment",
			  "exclude" : true,
			  "percentEncoded" : false
			}
			"""

		XCTAssertEqual(actual, expected)
	}

	func test__encode__minObject_defaultValue__encodesCorrectly() throws {
		let value = Components()

		let actual = try encodeToString(value)
		let expected = """
			{

			}
			"""

		XCTAssertEqual(actual, expected)
	}
}
