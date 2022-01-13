// MotionData+Decodable.swift
// Extensions
//
// Copyright © 2021 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension MotionData: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Self.MotionDataCodingKeys.self)
		
		let source: MotionDataSource = try container.decode(MotionDataSource.self, forKey: .source)
		let acceleration: Acceleration = try container.decode(Acceleration.self, forKey: .acceleration)
		let magneticField: MagneticField = try container.decode(MagneticField.self, forKey: .magneticField)
		let rotationRate: RotationRate = try container.decode(RotationRate.self, forKey: .rotationRate)
		
		self.init(source: source, acceleration: acceleration, magneticField: magneticField, rotationRate: rotationRate)
	}
}
