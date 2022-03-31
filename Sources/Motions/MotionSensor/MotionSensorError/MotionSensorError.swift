// MotionSensorError.swift
// Motions
//
// Copyright © 2021 Alexandre H. Saad
//

/// A representation of a motion sensor error.
internal enum MotionSensorError: Error {
	/// The specified sensor is inactive.
	case inactive(_ sensor: MotionSensor)
	
	/// The specified sensor is unavailable.
	case unavailable(_ sensor: MotionSensor? = nil)
	
	/// The frequencies are unequal.
	case unequalFrequencies
	
	/// The specified sensor is unable to resubscribe.
	case unresubscribable(_ sensor: MotionSensor? = nil)
}
