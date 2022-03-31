// MagneticField+PlottableInThreeDimensions.swift
// Motions
//
// Copyright © 2022 Alexandre H. Saad
//

import Extensions

extension MagneticField: PlottableInThreeDimensions {
	public init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}
}
