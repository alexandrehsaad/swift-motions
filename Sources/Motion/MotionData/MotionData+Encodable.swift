// MotionData+Encodable.swift
// Extensions
//
// Copyright © 2021 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension MotionData: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: Self.MotionDataCodingKeys.self)
		
		try container.encode(self.acceleration, forKey: .acceleration)
		try container.encode(self.magneticField, forKey: .magneticField)
		try container.encode(self.rotationRate, forKey: .rotationRate)
	}
}
