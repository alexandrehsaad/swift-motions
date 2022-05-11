// PlottableInTwoDimensions+.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension PlottableInTwoDimensions
where Self: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: PlottableCodingKeys.self)
		
		let x: Double = try container.decode(Double.self, forKey: .x)
		let y: Double = try container.decode(Double.self, forKey: .y)
		
		self.init(x: x, y: y)
	}
}

extension PlottableInTwoDimensions
where Self: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: PlottableCodingKeys.self)
		
		try container.encode(self.x, forKey: .x)
		try container.encode(self.y, forKey: .y)
	}
}
