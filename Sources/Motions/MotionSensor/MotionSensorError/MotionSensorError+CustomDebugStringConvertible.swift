// MotionSensorError+CustomDebugStringConvertible.swift
// Motions
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionSensorError: CustomDebugStringConvertible {
	internal var debugDescription: String {
		switch self {
		case .inactive(let sensor):
			return "\(sensor.rawValue.capitalized) is inactive"
		case .unavailable(let sensor):
			return "\(sensor?.rawValue.capitalized ?? "A sensor") is unavailable"
		case .unequalFrequencies:
			return "Some frequencies are unequal"
		case .unresubscribable(let sensor):
			return "\(sensor?.rawValue.capitalized ?? "A sensor") is unable to resubscribe."
		}
	}
}
