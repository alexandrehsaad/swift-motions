// Point.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import Measures

@available(*, deprecated, renamed: "Point")
public typealias Acceleration = Point

/// A structure representing a point in 3-dimension.
public struct Point {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance with the specified axes.
	///
	/// - Parameter x: The X-axis.
	/// - Parameter y: The Y-axis.
	/// - Parameter z: The Z-axis.
	public init<Unit>(x: Measure<Unit>, y: Measure<Unit>, z: Measure<Unit>)
	where Unit: Measurable {
		self.x = x.value
		self.y = y.value
		self.z =  z.value
	}
	
	// MARK: - Instance Properties
	
	public let x: Double
	
	public let y: Double
	
	public let z: Double
}
