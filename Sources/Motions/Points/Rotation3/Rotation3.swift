// Rotation3.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

@available(*, deprecated, renamed: "Rotation3")
public typealias Rotation = Rotation3

/// A structure representing a rotation in 3-dimension.
public struct Rotation3 {
	
	// MARK: - Creating Instances
	
	public init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}
	
	// MARK: - Instance Properties
	
	/// The value for the X-axis in gravitational force.
	public let x: Double
	
	/// The value for the Y-axis in gravitational force.
	public let y: Double
	
	/// The value for the Z-axis in gravitational force.
	public let z: Double
}
