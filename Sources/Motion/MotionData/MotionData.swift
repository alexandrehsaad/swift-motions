// MotionData.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

///
public struct MotionData {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance with the specified source acceleration, magnetic field and rotation rate.
	///
	/// - Parameter source: The source.
	/// - Parameter acceleration: The acceleration.
	/// - Parameter magneticField: The magnetic field.
	/// - Parameter rotationRate: The rotation rate.
	public init(
		source: MotionManagerDataSource,
		acceleration: Acceleration,
		magneticField: MagneticField,
		rotationRate: RotationRate
	) {
		self.source = source
		self.acceleration = acceleration
		self.magneticField = magneticField
		self.rotationRate = rotationRate
	}
	
	// MARK: - Instance Properties
	
	/// The source.
	public let source: MotionManagerDataSource
	
	/// The acceleration.
	public let acceleration: Acceleration
	
	/// The magnetic field.
	public let magneticField: MagneticField
	
	/// The rotation rate.
	public let rotationRate: RotationRate
}
