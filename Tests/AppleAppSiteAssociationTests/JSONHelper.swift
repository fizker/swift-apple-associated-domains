import Foundation

func encodeToString<T: Encodable>(_ value: T) throws -> String {
	let encoder = JSONEncoder()
	encoder.outputFormatting = [ .sortedKeys, .prettyPrinted ]
	let data = try encoder.encode(value)
	return String(data: data, encoding: .utf8)!
}

func decodeFromString<T: Decodable>(_ value: String) throws -> T {
	let decoder = JSONDecoder()
	let data = value.data(using: .utf8)!
	return try decoder.decode(T.self, from: data)
}
