import XCTest
import AppleAppSiteAssociation

final class AppLinksTests: XCTestCase {
	typealias AppLinks = AppleAppSiteAssociation.AppLinks

	func test__decode__minObject_defaultValue__decodesCorrectly() throws {
		let json = """
			{

			}
			"""

		let actual: AppLinks = try decodeFromString(json)
		let expected = AppLinks(details: [])

		XCTAssertEqual(actual, expected)
	}

	func test__decode__fullObject__decodesCorrectly() throws {
		let json = """
			{
			  "details": [
			    {
			      "appIDs": [ "foo", "bar" ]
			    }
			  ],
			  "defaults": {
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
			}
			"""

		let actual: AppLinks = try decodeFromString(json)
		let expected = AppLinks(
			details: [
				.init(appIDs: [ "foo", "bar" ]),
			],
			defaults: .init(
				path: "/some/path",
				query: [ "some": "query" ],
				fragment: "some-fragment",
				isExcludingMatches: true,
				comment: "Some comment",
				isCaseSensitive: false,
				isPercentEncoded: false
			)
		)

		XCTAssertEqual(expected, actual)
	}

	func test__encode__fullObject_nonDefaultValue__encodesCorrectly() throws {
		let value = AppLinks(
			details: [
				.init(appIDs: [ "foo", "bar" ]),
			],
			defaults: .init(
				path: "/some/path",
				query: [ "some": "query" ],
				fragment: "some-fragment",
				isExcludingMatches: true,
				comment: "Some comment",
				isCaseSensitive: false,
				isPercentEncoded: false
			)
		)

		let actual = try encodeToString(value)
		let expected = """
			{
			  "defaults" : {
			    "?" : {
			      "some" : "query"
			    },
			    "/" : "/some/path",
			    "#" : "some-fragment",
			    "caseSensitive" : false,
			    "comment" : "Some comment",
			    "exclude" : true,
			    "percentEncoded" : false
			  },
			  "details" : [
			    {
			      "appIDs" : [
			        "foo",
			        "bar"
			      ]
			    }
			  ]
			}
			"""

		XCTAssertEqual(actual, expected)
	}

	func test__encode__minObject_defaultValue__encodesCorrectly() throws {
		let value = AppLinks(details: [])

		let actual = try encodeToString(value)
		let expected = """
			{
			  "details" : [

			  ]
			}
			"""

		XCTAssertEqual(actual, expected)
	}
}
