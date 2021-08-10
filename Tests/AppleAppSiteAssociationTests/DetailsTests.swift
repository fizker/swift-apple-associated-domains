import XCTest
import AppleAppSiteAssociation

final class DetailsTests: XCTestCase {
	typealias Details = AppleAppSiteAssociation.AppLinks.Details

	func test__decode__minObject_defaultValue__decodesCorrectly() throws {
		let json = """
			{

			}
			"""

		let actual: Details = try decodeFromString(json)
		let expected = Details(appIDs: [])

		XCTAssertEqual(actual, expected)
	}

	func test__decode__fullObject__decodesCorrectly() throws {
		let json = """
			{
			  "appIDs": [
			    "foo"
			  ],
			  "components": [
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

		let actual: Details = try decodeFromString(json)
		let expected = Details(
			appIDs: [ "foo" ],
			defaults: .init(
				path: "/some/path",
				query: [ "some": "query" ],
				fragment: "some-fragment",
				isExcludingMatches: true,
				comment: "Some comment",
				isCaseSensitive: false,
				isPercentEncoded: false
			),
			components: [
				.init(
					path: "/some/path",
					query: [ "some": "query" ],
					fragment: "some-fragment",
					isExcludingMatches: true,
					comment: "Some comment",
					isCaseSensitive: false,
					isPercentEncoded: false
				)
			]
		)

		XCTAssertEqual(expected, actual)
	}

	func test__encode__fullObject_nonDefaultValue__encodesCorrectly() throws {
		let value = Details(
			appIDs: [ "foo" ],
			defaults: .init(
				path: "/some/path",
				query: [ "some": "query" ],
				fragment: "some-fragment",
				isExcludingMatches: true,
				comment: "Some comment",
				isCaseSensitive: false,
				isPercentEncoded: false
			),
			components: [
				.init(
					path: "/some/path",
					query: [ "some": "query" ],
					fragment: "some-fragment",
					isExcludingMatches: true,
					comment: "Some comment",
					isCaseSensitive: false,
					isPercentEncoded: false
				)
			]
		)

		let actual = try encodeToString(value)
		let expected = """
			{
			  "appIDs" : [
			    "foo"
			  ],
			  "components" : [
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
			  ],
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
			  }
			}
			"""

		XCTAssertEqual(actual, expected)
	}

	func test__encode__minObject_defaultValue__encodesCorrectly() throws {
		let value = Details(appIDs: [ ])

		let actual = try encodeToString(value)
		let expected = """
			{
			  "appIDs" : [

			  ]
			}
			"""

		XCTAssertEqual(actual, expected)
	}
}
