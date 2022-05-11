// Point+Randomizable.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Point {
	/// Returns a random instance within the specified closed range.
	///
	/// - parameter range: The range in which to create a random value.
	/// - returns: A random instance within the bounds of the range.
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
	
	/// Returns a random instance within the specified range.
	///
	/// - parameter range: The range in which to create a random value.
	/// - returns: A random instance within the bounds of the range.
	public static func random(in range: Range<Self>) -> Self {
		let newRange: ClosedRange<Self> = range.lowerBound...range.upperBound
		return self.random(in: newRange)
	}
}
