// MotionSensorError.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

/// A representation of a motion sensor error.
public enum MotionSensorError: Error {
	/// The specified sensor is inactive.
	case inactive(_ sensor: MotionSensor)
	
	/// The specified sensor is unavailable.
	case unavailable(_ sensor: MotionSensor)
}
