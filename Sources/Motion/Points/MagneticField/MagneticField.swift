// MagneticField.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

// FIXME: update to newtype when available in swift.
/// A structure containing 3-axis magnetic field values.
public typealias MagneticField = Point3

extension MagneticField {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance with the specified axes.
	///
	/// - Parameters:
	///   - x: The X-axis.
	///   - y: The Y-axis.
	///   - z: The Z-axis.
	public init(x:  Measure<MagneticFluxDensity>, y:  Measure<MagneticFluxDensity>, z:  Measure<MagneticFluxDensity>) {
		let x: Double = x.converted(to: .microtesla).value
		let y: Double = y.converted(to: .microtesla).value
		let z: Double = z.converted(to: .microtesla).value
		
		self.init(x: x, y: y, z: z)
	}
}
