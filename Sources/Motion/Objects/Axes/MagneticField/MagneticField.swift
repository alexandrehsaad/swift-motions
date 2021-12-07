// MagneticField.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

import Measures

/// A structure containing 3-axis magnetic field values.
public struct MagneticField: Equatable, Hashable, Sendable {
	/// The value for the X-axis magnetic field in microteslas.
	public let x: Measure<MagneticFluxDensity>
	
	/// The value for the Y-axis magnetic field in microteslas.
	public let y: Measure<MagneticFluxDensity>
	
	/// The value for the Y-axis magnetic field in microteslas.
	public let z: Measure<MagneticFluxDensity>
	
	/// Creates a new instance with the specified axes in microteslas.
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
