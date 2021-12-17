// RotationRate+Randomizable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension RotationRate: Randomizable {
	public static func random(in range: ClosedRange<Self>) -> Self {
		let rangeX: ClosedRange<Double> = range.lowerBound.x...range.upperBound.x
		let rangeY: ClosedRange<Double> = range.lowerBound.y...range.upperBound.y
		let rangeZ: ClosedRange<Double> = range.lowerBound.z...range.upperBound.z
		
		return self.init(
			x: .random(in: rangeX),
			y: .random(in: rangeY),
			z: .random(in: rangeZ)
		)
	}
}
