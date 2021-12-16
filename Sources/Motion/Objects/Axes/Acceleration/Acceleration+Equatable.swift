// Acceleration+Equatable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension Acceleration: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.x == rhs.x
			&& lhs.y == rhs.y
			&& lhs.z == rhs.z
	}
}
