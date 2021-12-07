// MotionSensorError+CustomDebugStringConvertible.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionSensorError: CustomDebugStringConvertible {
	public var debugDescription: String {
		switch self {
		case .inactive(let sensor):
			return "\(sensor.rawValue) is inactive"
		case .unavailable(let sensor):
			return "\(sensor.rawValue) is unavailable"
		}
	}
}
