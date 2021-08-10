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

	func test__decode__sampleFromDocs__decodesCorrectly() throws {
		let json = """
			{
				"applinks": {
					"details": [
						{
							"appIDs": [ "ABCDE12345.com.example.app", "ABCDE12345.com.example.app2" ],
							"components": [
								{
									"#": "no_universal_links",
									"exclude": true,
									"comment": "Matches any URL whose fragment equals no_universal_links and instructs the system not to open it as a universal link"
								},
								{
									"/": "/buy/*",
									"comment": "Matches any URL whose path starts with /buy/"
								},
								{
									"/": "/help/website/*",
									"exclude": true,
									"comment": "Matches any URL whose path starts with /help/website/ and instructs the system not to open it as a universal link"
								},
								{
									"/": "/help/*",
									"?": { "articleNumber": "????" },
									"comment": "Matches any URL whose path starts with /help/ and which has a query item with name 'articleNumber' and a value of exactly 4 characters"
								}
							]
						}
					]
				},
				"webcredentials": {
					"apps": [ "ABCDE12345.com.example.app" ]
				},
				"appclips": {
					"apps": ["ABCED12345.com.example.MyApp.Clip"]
				}
			}
			"""
		let expected = AppleAppSiteAssociation(
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

		let actual: AppleAppSiteAssociation = try decodeFromString(json)

		XCTAssertEqual(actual, expected)
	}

	func test__encode__sampleFromDocs__encodesCorrectly() throws {
		let expected = """
			{
			  "appclips" : {
			    "apps" : [
			      "ABCED12345.com.example.MyApp.Clip"
			    ]
			  },
			  "applinks" : {
			    "details" : [
			      {
			        "appIDs" : [
			          "ABCDE12345.com.example.app",
			          "ABCDE12345.com.example.app2"
			        ],
			        "components" : [
			          {
			            "#" : "no_universal_links",
			            "comment" : "Matches any URL whose fragment equals no_universal_links and instructs the system not to open it as a universal link",
			            "exclude" : true
			          },
			          {
			            "/" : "/buy/*",
			            "comment" : "Matches any URL whose path starts with /buy/"
			          },
			          {
			            "/" : "/help/website/*",
			            "comment" : "Matches any URL whose path starts with /help/website/ and instructs the system not to open it as a universal link",
			            "exclude" : true
			          },
			          {
			            "?" : {
			              "articleNumber" : "????"
			            },
			            "/" : "/help/*",
			            "comment" : "Matches any URL whose path starts with /help/ and which has a query item with name 'articleNumber' and a value of exactly 4 characters"
			          }
			        ]
			      }
			    ]
			  },
			  "webcredentials" : {
			    "apps" : [
			      "ABCDE12345.com.example.app"
			    ]
			  }
			}
			"""

		let input = AppleAppSiteAssociation(
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

		let actual = try encodeToString(input)

		XCTAssertEqual(actual, expected)
	}
}
