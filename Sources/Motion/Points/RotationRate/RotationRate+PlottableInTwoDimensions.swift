// RotationRate+PlottableInTwoDimensions.swift
// Motion
//
// Copyright © 2022 Alexandre H. Saad
//

extension RotationRate: PlottableInTwoDimensions {
	public init(x: Double, y: Double) {
		self.init(x: x, y: y, z: 0)
	}
}
