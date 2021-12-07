// Rotation.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

/// A structure representing a measurement of rotation rate.
public struct RotationRate: Equatable, Hashable, Sendable {
	/// The value for the X-axis.
	public let x: Double
	
	/// The value for the Y-axis.
	public let y: Double
	
	/// The value for the Z-axis.
	public let z: Double
	
	/// Creates a new instance with the specified axes.
	///
	/// - Parameters:
	///   - x: The X-axis.
	///   - y: The Y-axis.
	///   - z: The Z-axis.
	public init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}
}
