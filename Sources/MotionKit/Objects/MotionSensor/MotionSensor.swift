// MotionSensor.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

/// A representation of a motion sensor.
public enum MotionSensor: String {
	/// The accelerometer motion sensor.
	case accelerometer
	
	/// The altimeter motion sensor.
	@available(*, unavailable)
	case altimeter
	
	/// The gyroscope motion sensor.
	case gyroscope
	
	/// The magnetometer motion sensor.
	case magnetometer
}
