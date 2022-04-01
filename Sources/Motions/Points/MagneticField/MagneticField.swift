// MagneticField.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A structure containing 3-axis magnetic field values.
public struct MagneticField {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance with the specified axes.
	///
	/// - Parameter x: The X-axis.
	/// - Parameter y: The Y-axis.
	/// - Parameter z: The Z-axis.
	public init(x: Measure<Force>, y: Measure<Force>, z: Measure<Force>) {
		let x: Double = x.converted(to: .gravity(per: .kilogram)).value
		let y: Double = y.converted(to: .gravity(per: .kilogram)).value
		let z: Double =  z.converted(to: .gravity(per: .kilogram)).value

		self.init(x: x, y: y, z: z)
	}
	
	// MARK: - Instance Properties
	
	/// The value for the X-axis in gravitational force.
	public let x: Double
	
	/// The value for the Y-axis in gravitational force.
	public let y: Double
	
	/// The value for the Z-axis in gravitational force.
	public let z: Double
}
