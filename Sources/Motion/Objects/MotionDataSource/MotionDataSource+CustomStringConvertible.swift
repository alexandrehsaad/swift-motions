// MotionDataSource+CustomStringConvertible.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionDataSource: CustomStringConvertible {
	public var description: String {
		switch self {
		case .phone:
			return "Apple iPhone"
		case .watch:
			return "Apple Watch"
		}
	}
}
