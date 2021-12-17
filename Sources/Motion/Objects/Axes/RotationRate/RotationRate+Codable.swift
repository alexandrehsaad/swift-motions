// RotationRate+Codable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

import Measures

extension RotationRate {
	fileprivate enum CodingKeys: String, CodingKey {
		case x = "x"
		case y = "y"
		case z = "z"
	}
}

// MARK: - Decodable

extension RotationRate: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Self.CodingKeys.self)
		
		let x: Double = try container.decode(Double.self, forKey: .x)
		let y: Double = try container.decode(Double.self, forKey: .y)
		let z: Double = try container.decode(Double.self, forKey: .z)
		
		self.init(x: x, y: y, z: z)
	}
}

// MARK: - Encodable

extension RotationRate: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: Self.CodingKeys.self)
		
		try container.encode(self.x, forKey: .x)
		try container.encode(self.y, forKey: .y)
		try container.encode(self.z, forKey: .z)
	}
}
