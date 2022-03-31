// MagneticField+PlottableInTwoDimensions.swift
// Motions
//
// Copyright © 2022 Alexandre H. Saad
//

extension MagneticField: PlottableInTwoDimensions {
	public init(x: Double, y: Double) {
		self.init(x: x, y: y, z: 0)
	}
}
