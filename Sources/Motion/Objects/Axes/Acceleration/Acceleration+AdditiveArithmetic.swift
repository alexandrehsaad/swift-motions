// Acceleration+AdditiveArithmetic.swift
// Motion
//
// Copyright © 2021 A. H. de Quatre Ltd.
//

extension Acceleration: AdditiveArithmetic {
	public static let zero: Self = .init(x: .zero, y: .zero, z: .zero)
	
	/// Adds two values and produces their sum.
	///
	/// - Parameters:
	///   - lhs: A first value to add.
	///   - rhs: The second value to add.
	/// - Returns: The sum.
	public static func + (_ lhs: Self, _ rhs: Self) -> Self {
		let x: Double = lhs.x.value + rhs.x.value
		let y: Double = lhs.y.value + rhs.y.value
		let z: Double = lhs.z.value + rhs.z.value
		
		return .init(x: x, y: y, z: z)
	}
	
	/// Adds two values and stores the result in the left-hand-side variable.
	///
	/// - Parameters:
	///   - lhs: A first value to add.
	///   - rhs: The second value to add.
	public static func += (_ lhs: inout Self, _ rhs: Self) {
		lhs = lhs + rhs
	}
	
	/// Subtracts one value from another and produces their difference.
	///
	/// - Parameters:
	///   - lhs: A numeric value.
	///   - rhs: The value to subtract from lhs.
	/// - Returns: The difference.
	public static func - (_ lhs: Self, _ rhs: Self) -> Self {
		let x: Double = lhs.x.value - rhs.x.value
		let y: Double = lhs.y.value - rhs.y.value
		let z: Double = lhs.z.value - rhs.z.value
		
		return .init(x: x, y: y, z: z)
	}
	
	/// Subtracts the second value from the first and stores the difference in the left-hand-side variable.
	///
	/// - Parameters:
	///   - lhs: A numeric value.
	///   - rhs: The value to subtract from lhs.
	public static func -= (_ lhs: inout Self, _ rhs: Self) {
		lhs = lhs - rhs
	}
}
