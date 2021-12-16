// MagneticField.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

import Measures

/// A structure containing 3-axis magnetic field values.
public struct MagneticField: Codable, Sendable {
	/// The value for the X-axis in microteslas.
	public let x: Measure<MagneticFluxDensity>
	
	/// The value for the Y-axis in microteslas.
	public let y: Measure<MagneticFluxDensity>
	
	/// The value for the Y-axis in microteslas.
	public let z: Measure<MagneticFluxDensity>
	
	/// Creates a new instance with the specified axes.
	///
	/// - Parameters:
	///   - x: The X-axis.
	///   - y: The Y-axis.
	///   - z: The Z-axis.
	public init(x: Double, y: Double, z: Double) {
		self.x = .init(x, .microtesla)
		self.y = .init(y, .microtesla)
		self.z = .init(z, .microtesla)
	}
}
