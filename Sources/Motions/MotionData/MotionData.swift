// MotionData.swift
// Motions
//
// Copyright © 2021 Alexandre H. Saad
//

/// A structure containing all three sensors.
internal struct MotionData {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance with the specified source acceleration, magnetic field and rotation rate.
	///
	/// - Parameter acceleration: The acceleration.
	/// - Parameter magneticField: The magnetic field.
	/// - Parameter rotationRate: The rotation rate.
	public init(
		acceleration: Acceleration,
		magneticField: MagneticField,
		rotationRate: RotationRate
	) {
		self.acceleration = acceleration
		self.magneticField = magneticField
		self.rotationRate = rotationRate
	}
	
	// MARK: - Instance Properties
	
	/// The acceleration.
	public let acceleration: Acceleration
	
	/// The magnetic field.
	public let magneticField: MagneticField
	
	/// The rotation rate.
	public let rotationRate: RotationRate
}
