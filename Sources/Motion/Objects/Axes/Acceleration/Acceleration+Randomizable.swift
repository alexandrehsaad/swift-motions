// Acceleration+Randomizable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension Acceleration: Randomizable {
	public static func random(in range: ClosedRange<Self>) -> Self {
		let rangeX: ClosedRange<Self.Unit> = range.lowerBound.x...range.upperBound.x
		let rangeY: ClosedRange<Self.Unit> = range.lowerBound.y...range.upperBound.y
		let rangeZ: ClosedRange<Self.Unit> = range.lowerBound.z...range.upperBound.z
		
		return self.init(
			x: .random(in: rangeX),
			y: .random(in: rangeY),
			z: .random(in: rangeZ)
		)
	}
}
