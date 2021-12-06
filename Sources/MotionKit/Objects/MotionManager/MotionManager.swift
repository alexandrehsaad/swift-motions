// MotionManager.swift
// MotionKit
//
// Copyright © 2021 Alexandre H. Saad
//

import Measures

#if canImport(CoreMotion)

import Combine
import CoreMotion

///
public class MotionManager: ObservableObject {
	/// Creates a new instance.
	private init() {}
	
	/// The underlying motion manager from Apple's CoreMotion framework..
	private let motionManager: CMMotionManager = .init()
	
	/// The unique shared instance.
	public static let shared: MotionManager = .init()
	
	/// Updates the specified sensor frequency.
	///
	/// - Parameters:
	///   - sensor: The sensor to update.
	///   - frequency: The new frequency.
	public func update(_ sensor: MotionSensor, to frequency: Measure<Frequency>) {
		switch sensor {
		case .accelerometer:
			self.updateAccelerometer(to: frequency)
			
		case .gyrometer:
			self.updateGyrometer(to: frequency)
			
		case .magnetometer:
			self.updateMagnetometer(to: frequency)
		}
	}
	
	/// Subscribes to the specified sensor.
	///
	/// - Parameter sensor: The sensor to subscribe to.
	/// - Throws: A motion sensor error.
	public func subscribe(to sensor: MotionSensor) throws {
		switch sensor {
		case .accelerometer:
			try self.subscribeToAccelerometer()
			
		case .gyrometer:
			try self.subscribeToGyrometer()
			
		case .magnetometer:
			try self.subscribeToMagnetometer()
		}
	}
	
	/// Unsubscribes from the specified sensor to stop updates.
	///
	/// - Parameter sensor: The sensor to unsubscribe from.
	/// - Throws: A motion error.
	public func unsubscribe(from sensor: MotionSensor) throws {
		switch sensor {
		case .accelerometer:
			try self.unsubscribeFromAccelerometer()
			
		case .gyrometer:
			try self.unsubscribeFromGyrometer()
			
		case .magnetometer:
			try self.unsubscribeFromMagnetometer()
		}
	}
}

// MARK: - Accelerometer

extension MotionManager {
	/// The latest sample of data from the accelerometer.
	public var lastAcceleration: Acceleration? {
		guard let data = self.motionManager.accelerometerData else {
			return nil
		}
		
		return .init(
			x: data.acceleration.x,
			y: data.acceleration.y,
			z: data.acceleration.z
		)
	}
	
	/// A boolean value indicating whether the accelerometer is available.
	public var isAccelerometerAvailable: Bool {
		return self.motionManager.isAccelerometerAvailable
	}
	
	/// A boolean value indicating whether the accelerometer is active.
	public var isAccelerometerActive: Bool {
		return self.motionManager.isAccelerometerActive
	}
	
	/// The cycles per second at which to deliver accelerometer data.
	public var accelerometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.accelerometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// Updates the accelerometer frequency.
	private func updateAccelerometer(to frequency: Measure<Frequency>) {
		self.motionManager.accelerometerUpdateInterval = frequency.converted(to: .second).value
	}
	
	/// Subscribes to the accelerometer.
	///
	/// - Throws: A motion sensor error.
	private func subscribeToAccelerometer() throws {
		guard self.isAccelerometerAvailable else {
			throw MotionSensorError.unavailable(.accelerometer)
		}
		
		self.motionManager.startAccelerometerUpdates()
	}
	
	/// Unsubscribes from the accelerometer.
	///
	/// - Throws: A motion sensor error.
	private func unsubscribeFromAccelerometer() throws {
		guard self.isAccelerometerActive else {
			throw MotionSensorError.inactive(.accelerometer)
		}
		
		self.motionManager.stopAccelerometerUpdates()
	}
}

// MARK: - Gyrometer
	
extension MotionManager {
	/// The latest sample of data from the gyrometer.
	public var lastRotation: Rotation? {
		guard let data = self.motionManager.gyroData else {
			return nil
		}
		
		return .init(
			x: data.rotationRate.x,
			y: data.rotationRate.y,
			z: data.rotationRate.z
		)
	}
	
	/// A boolean value indicating whether the gyrometer is available.
	public var isGyrometerAvailable: Bool {
		return self.motionManager.isMagnetometerAvailable
	}
	
	/// A boolean value indicating whether the gyrometer is active.
	public var isGyrometerActive: Bool {
		return self.motionManager.isMagnetometerActive
	}
	
	/// The cycles per second at which to deliver gyrometer data.
	public var gyrometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.gyroUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// Updates the gyrometer frequency.
	private func updateGyrometer(to frequency: Measure<Frequency>) {
		self.motionManager.gyroUpdateInterval = frequency.converted(to: .second).value
	}
	
	/// Subscribes to the gyrometer.
	///
	/// - Throws: A motion sensor error.
	private func subscribeToGyrometer() throws {
		guard self.isGyrometerAvailable else {
			throw MotionSensorError.unavailable(.gyrometer)
		}
		
		self.motionManager.startGyroUpdates()
	}
	
	/// Unsubscribes from the gyrometer.
	///
	/// - Throws: A motion sensor error.
	private func unsubscribeFromGyrometer() throws {
		guard self.isGyrometerActive else {
			throw MotionSensorError.inactive(.gyrometer)
		}
		
		self.motionManager.stopGyroUpdates()
	}
}
	
// MARK: - Magnetometer
	
extension MotionManager {
	/// The latest sample of data from the magnetometer.
	public var lastMagneticField: MagneticField? {
		guard let data = self.motionManager.magnetometerData else {
			return nil
		}
		
		return .init(
			x: data.magneticField.x,
			y: data.magneticField.y,
			z: data.magneticField.z
		)
	}
	
	/// A boolean value indicating whether the magnetometer is available.
	public var isMagnetometerAvailable: Bool {
		return self.motionManager.isMagnetometerAvailable
	}
	
	/// A boolean value indicating whether the magnetometer is active.
	public var isMagnetometerActive: Bool {
		return self.motionManager.isMagnetometerActive
	}
	
	/// The cycles per second at which to deliver magnetometer data.
	public var magnetometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.magnetometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// Updates the magnetometer frequency.
	private func updateMagnetometer(to frequency: Measure<Frequency>) {
		self.motionManager.magnetometerUpdateInterval = frequency.converted(to: .second).value
	}
	
	/// Subscribes to the magnetometer.
	///
	/// - Throws: A motion sensor error.
	private func subscribeToMagnetometer() throws {
		guard self.isMagnetometerAvailable else {
			throw MotionSensorError.unavailable(.magnetometer)
		}
		
		self.motionManager.startMagnetometerUpdates()
	}
	
	/// Unsubscribes from the magnetometer.
	///
	/// - Throws: A motion sensor error.
	private func unsubscribeFromMagnetometer() throws {
		guard self.isMagnetometerActive else {
			throw MotionSensorError.inactive(.magnetometer)
		}
		
		self.motionManager.stopMagnetometerUpdates()
	}
}

#endif
