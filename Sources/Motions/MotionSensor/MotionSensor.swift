// MotionSensor.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
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
