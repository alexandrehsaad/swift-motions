// MotionData.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

///
public struct MotionData: Codable, Sendable {
	/// The source.
	public let source: MotionDataSource
	
	/// The acceleration.
	public let acceleration: Acceleration
	
	/// The magnetic field.
	public let magneticField: MagneticField
	
	/// The rotation rate.
	public let rotationRate: RotationRate
	
	/// Creates a new instance with the specified source acceleration, magnetic field and rotation rate.
	///
	/// - Parameters:
	///   - source: The source.
	///   - acceleration: The acceleration.
	///   - magneticField: The magnetic field.
	///   - rotationRate: The rotation rate.
	public init(
		source: MotionDataSource,
		acceleration: Acceleration,
		magneticField: MagneticField,
		rotationRate: RotationRate
	) {
		self.source = source
		self.acceleration = acceleration
		self.magneticField = magneticField
		self.rotationRate = rotationRate
	}
}
