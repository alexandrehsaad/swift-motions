// MagneticField.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

/// A structure containing 3-axis magnetic field values.
public struct MagneticField {
	///
	public typealias Unit = Measure<MagneticFluxDensity>
	
	/// The value for the X-axis in microteslas.
	@Converted(to: .microtesla)
	public private(set) var x: Self.Unit = .init(1, .base)
	
	/// The value for the Y-axis in microteslas.
	@Converted(to: .microtesla)
	public private(set) var y: Self.Unit = .init(1, .base)
	
	/// The value for the Y-axis in microteslas.
	@Converted(to: .microtesla)
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
		self.x = .init(x, .microtesla)
		self.y = .init(y, .microtesla)
		self.z = .init(z, .microtesla)
	}
}
