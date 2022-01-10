// MotionData+Equatable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionData: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.acceleration == rhs.acceleration
			&& lhs.magneticField == rhs.magneticField
			&& lhs.rotationRate == rhs.rotationRate
	}
}
