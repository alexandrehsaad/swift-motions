// Acceleration+PlottableInThreeDimensions.swift
// Motion
//
// Copyright © 2022 Alexandre H. Saad
//

extension Acceleration: PlottableInThreeDimensions {
	public init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}
}
