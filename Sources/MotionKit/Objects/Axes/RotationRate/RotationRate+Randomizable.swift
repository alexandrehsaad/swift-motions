// RotationRate+Randomizable.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

extension RotationRate {
	/// Returns a random instance within the specified range.
	///
	/// - Parameter range: The range in which to create a random value.
	/// - Returns: A random instance within the bounds of the range.
	static func random(in range: ClosedRange<Double> = -1...1) -> Self {
		return self.init(
			x: .random(in: range),
			y: .random(in: range),
			z: .random(in: range)
		)
	}
}
