// Acceleration.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

// FIXME: update to newtype when available in swift.
/// A structure containing 3-axis acceleration values.
public typealias Acceleration = Point3

extension Acceleration {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance with the specified axes.
	///
	/// - Parameters:
	///   - x: The X-axis.
	///   - y: The Y-axis.
	///   - z: The Z-axis.
	public init(x: Measure<Force>, y: Measure<Force>, z: Measure<Force>) {
		let x: Double = x.converted(to: .gravity(per: .kilogram)).value
		let y: Double = y.converted(to: .gravity(per: .kilogram)).value
		let z: Double =  z.converted(to: .gravity(per: .kilogram)).value
		
		self.init(x: x, y: y, z: z)
	}
}
