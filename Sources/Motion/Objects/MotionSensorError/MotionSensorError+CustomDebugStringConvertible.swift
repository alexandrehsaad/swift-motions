// MotionSensorError+CustomDebugStringConvertible.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionSensorError: CustomDebugStringConvertible {
	public var debugDescription: String {
		switch self {
		case .inactive(let sensor):
			return "\(sensor.rawValue) is inactive"
		case .unavailable(let sensor):
			return "\(sensor?.rawValue ?? "A sensor") is unavailable"
		case .unequalFrequencies:
			return "Some frequencies are unequal"
		case .unresubscribable(let sensor):
			return "\(sensor?.rawValue ?? "A sensor") is unable to resubscribe."
		}
	}
}
