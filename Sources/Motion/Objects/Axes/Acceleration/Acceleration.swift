// Acceleration.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

import Measures

/// A structure containing 3-axis acceleration values.
public struct Acceleration {
	///
	public typealias Unit = Measure<Force>
	
	/// The value for the X-axis in gravitational force.
	@Converted(to: .gravity(per: .kilogram))
	public private(set) var x: Self.Unit = .init(1, .base)
	
	/// The value for the Y-axis in gravitational force.
	@Converted(to: .gravity(per: .kilogram))
	public private(set) var y: Self.Unit = .init(1, .base)
	
	/// The value for the Z-axis in gravitational force.
	@Converted(to: .gravity(per: .kilogram))
	public private(set) var z: Self.Unit = .init(1, .base)
	
	/// Creates a new instance with the specified axes.
	///
	/// - Parameters:
	///   - x: The X-axis.
	///   - y: The Y-axis.
	///   - z: The Z-axis.
	public init(x: Self.Unit, y: Self.Unit, z: Self.Unit) {
		self.x = x
		self.y = y
		self.z = z
	}
	
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
