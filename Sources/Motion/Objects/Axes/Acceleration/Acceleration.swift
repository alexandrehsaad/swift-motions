// Acceleration.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

import Arithmetics
import Measures

/// A structure containing 3-axis acceleration values.
public struct Acceleration: Codable, Equatable, Hashable, Sendable {
	/// The value for the X-axis in gravitational force.
	public let x: Measure<Force>
	
	/// The value for the Y-axis in gravitational force.
	public let y: Measure<Force>
	
	/// The value for the Z-axis in gravitational force.
	public let z: Measure<Force>
	
	/// Creates a new instance with the specified axes.
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
