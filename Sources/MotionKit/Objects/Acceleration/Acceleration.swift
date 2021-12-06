// Acceleration.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

import Arithmetics
import Measures

/// A structure containing 3-axis acceleration values.
public struct Acceleration: Equatable, Hashable, Sendable {
	/// X-axis acceleration in gravitational force.
	public let x: Measure<Force>
	
	/// Y-axis acceleration in gravitational force.
	public let y: Measure<Force>
	
	/// Z-axis acceleration in gravitational force.
	public let z: Measure<Force>
	
	/// Creates a new instance with the specified x, y and z axes in gravitational force.
	///
	/// - Parameters:
	///   - x: The X-axis.
	///   - y: The Y-axis.
	///   - z: The Z-axis.
	public init(x: Double, y: Double, z: Double) {
		self.x = .init(x, .gravity(per: .kilogram))
		self.y = .init(y, .gravity(per: .kilogram))
		self.z = .init(z, .gravity(per: .kilogram))
	}
}
