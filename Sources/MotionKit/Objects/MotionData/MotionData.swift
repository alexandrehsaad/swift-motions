// MotionData.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

///
public struct MotionData: Equatable, Hashable {
	/// The timestamp.
	public let timestamp: Double
	
	/// The acceleration.
	public let acceleration: Acceleration
	
	/// The magnetic field.
	public let magneticField: MagneticField
	
	/// The rotation.
	public let rotation: Rotation
	
	/// Creates a new instance with the specified timestamp, acceleration, magnetic field and rotation.
	///
	/// - Parameters:
	///   - timestamp: The timestamp.
	///   - acceleration: The acceleration.
	///   - magneticField: The magnetic field.
	///   - rotation: The rotation.
	public init(
		timestamp: Double,
		acceleration: Acceleration,
		magneticField: MagneticField,
		rotation: Rotation
	) {
		self.timestamp = timestamp
		self.acceleration = acceleration
		self.magneticField = magneticField
		self.rotation = rotation
	}
}
