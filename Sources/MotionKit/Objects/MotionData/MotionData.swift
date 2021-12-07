// MotionData.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

///
public struct MotionData: Equatable, Hashable, Sendable {
	/// The acceleration.
	public let acceleration: Acceleration
	
	/// The magnetic field.
	public let magneticField: MagneticField
	
	/// The rotation rate.
	public let rotationRate: RotationRate
	
	/// Creates a new instance with the specified acceleration, magnetic field and rotation rate.
	///
	/// - Parameters:
	///   - acceleration: The acceleration.
	///   - magneticField: The magnetic field.
	///   - rotationRate: The rotation rate.
	public init(
		acceleration: Acceleration,
		magneticField: MagneticField,
		rotationRate: RotationRate
	) {
		self.acceleration = acceleration
		self.magneticField = magneticField
		self.rotationRate = rotationRate
	}
}
