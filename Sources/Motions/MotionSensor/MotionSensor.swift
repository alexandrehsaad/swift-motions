// MotionSensor.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

/// A representation of a motion sensor.
@frozen
public enum MotionSensor: String, CaseIterable {
	/// The accelerometer motion sensor.
	case accelerometer
	
	/// The gyrometer motion sensor.
	case gyrometer
	
	/// The magnetometer motion sensor.
	case magnetometer
}
