// RotationRate+PlottableInTwoDimensions.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension RotationRate: PlottableInTwoDimensions {
	public init(x: Double, y: Double) {
		self.init(x: x, y: y, z: 0)
	}
}
