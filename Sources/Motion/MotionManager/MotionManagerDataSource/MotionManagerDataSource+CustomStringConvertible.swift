// MotionManagerDataSource+CustomStringConvertible.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionManagerDataSource: CustomStringConvertible {
	public var description: String {
		switch self {
		case .simulator:
			return "Simulator"
		case .phone:
			return "Apple iPhone"
		case .watch:
			return "Apple Watch"
		}
	}
}
