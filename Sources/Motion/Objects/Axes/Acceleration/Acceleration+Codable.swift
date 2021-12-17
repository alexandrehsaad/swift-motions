// Acceleration+Codable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension Acceleration {
	fileprivate enum CodingKeys: String, CodingKey {
		case x = "x"
		case y = "y"
		case z = "z"
	}
}

// MARK: - Decodable

extension Acceleration: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Self.CodingKeys.self)
		
		let x: Measure<Force> = try container.decode(Unit.self, forKey: .x)
		let y: Measure<Force> = try container.decode(Unit.self, forKey: .y)
		let z: Measure<Force> = try container.decode(Unit.self, forKey: .z)
		
		self.init(x: x, y: y, z: z)
	}
}

// MARK: - Encodable

extension Acceleration: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: Self.CodingKeys.self)
		
		try container.encode(self.x, forKey: .x)
		try container.encode(self.y, forKey: .y)
		try container.encode(self.z, forKey: .z)
	}
}
