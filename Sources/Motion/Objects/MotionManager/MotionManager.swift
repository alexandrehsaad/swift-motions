// MotionManager.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

import Measures

#if canImport(CoreMotion)

import CoreMotion

/// A reprensentation of the motion manager.
public class MotionManager {
	/// Creates a new instance.
	private init() {}
	
	/// The underlying motion manager from Apple's CoreMotion framework..
	private let motionManager: CMMotionManager = .init()
	
	/// The shared instance.
	public static let shared: MotionManager = .init()
	
	/// Unsubscribes from the specified sensor.
	///
	/// - Parameter sensor: The sensor to unsubscribe from.
	/// - Throws: A motion sensor error.
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
	
	/// Unsubscribes from the specified sensors.
	///
	/// - Parameter sensors: The sensors to unsubscribe from.
	/// - Throws: A motion sensor error.
	public func unsubscribe(from sensors: Set<MotionSensor>) throws {
		for sensor in sensors {
			try self.unsubscribe(from: sensor)
		}
	}
	
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
	
	/// Updates the specified sensors frequency.
	///
	/// - Parameters:
	///   - sensors: The sensors to update.
	///   - frequency: The new frequency.
	public func update(_ sensors: Set<MotionSensor>, to frequency: Measure<Frequency>) {
		for sensor in sensors {
			self.update(sensor, to: frequency)
		}
	}
}

// MARK: - Accelerometer

extension MotionManager {
	/// A boolean value indicating whether the accelerometer is active.
	public var isAccelerometerActive: Bool {
		return self.motionManager.isAccelerometerActive
	}
	
	/// A boolean value indicating whether the accelerometer is available.
	public var isAccelerometerAvailable: Bool {
		return self.motionManager.isAccelerometerAvailable
	}
	
	/// The cycles per second at which to deliver accelerometer data.
	public var accelerometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.accelerometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
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
	
	/// Subscribes to the accelerometer.
	///
	/// - Returns: An asynchronous stream of data from the accelerometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macOS 12, watchOS 8, *)
	public func subscribeToAccelerometer() throws -> AsyncStream<Acceleration> {
		guard self.isAccelerometerAvailable else {
			throw MotionSensorError.unavailable(.accelerometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startAccelerometerUpdates(to: OperationQueue()) { (data, _) in
				if let data = data {
					let acceleration: Acceleration = .init(
						x: data.acceleration.x,
						y: data.acceleration.y,
						z: data.acceleration.z
					)
					
					continuation.yield(acceleration)
				} else {
					continuation.finish()
				}
			}
		}
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
	
	/// Updates the accelerometer frequency.
	private func updateAccelerometer(to frequency: Measure<Frequency>) {
		self.motionManager.accelerometerUpdateInterval = frequency.converted(to: .second).value
	}
}

// MARK: - Gyrometer
	
extension MotionManager {
	/// A boolean value indicating whether the gyrometer is active.
	public var isGyrometerActive: Bool {
		return self.motionManager.isGyroActive
	}
	
	/// A boolean value indicating whether the gyrometer is available.
	public var isGyrometerAvailable: Bool {
		return self.motionManager.isGyroAvailable
	}
	
	/// The cycles per second at which to deliver gyrometer data.
	public var gyrometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.gyroUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// The latest sample of data from the gyrometer.
	public var lastRotation: RotationRate? {
		guard let data = self.motionManager.gyroData else {
			return nil
		}
		
		return .init(
			x: data.rotationRate.x,
			y: data.rotationRate.y,
			z: data.rotationRate.z
		)
	}
	
	/// Subscribes to the gyrometer.
	///
	/// - Returns: An asynchronous stream of data from the gyrometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macOS 12, watchOS 8, *)
	public func subscribeToGyrometer() throws -> AsyncStream<RotationRate> {
		guard self.isGyrometerAvailable else {
			throw MotionSensorError.unavailable(.gyrometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startGyroUpdates(to: OperationQueue()) { (data, _) in
				if let data = data {
					let rotationRate: RotationRate = .init(
						x: data.rotationRate.x,
						y: data.rotationRate.y,
						z: data.rotationRate.z
					)
					
					continuation.yield(rotationRate)
				} else {
					continuation.finish()
				}
			}
		}
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
	
	/// Updates the gyrometer frequency.
	private func updateGyrometer(to frequency: Measure<Frequency>) {
		self.motionManager.gyroUpdateInterval = frequency.converted(to: .second).value
	}
}
	
// MARK: - Magnetometer
	
extension MotionManager {
	/// A boolean value indicating whether the magnetometer is active.
	public var isMagnetometerActive: Bool {
		return self.motionManager.isMagnetometerActive
	}
	
	/// A boolean value indicating whether the magnetometer is available.
	public var isMagnetometerAvailable: Bool {
		return self.motionManager.isMagnetometerAvailable
	}
	
	/// The cycles per second at which to deliver magnetometer data.
	public var magnetometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.magnetometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
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
	
	/// Subscribes to the magnetometer.
	///
	/// - Returns: An asynchronous stream of data from the magnetometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macOS 12, watchOS 8, *)
	public func subscribeToMagnetometer() throws -> AsyncStream<MagneticField> {
		guard self.isMagnetometerAvailable else {
			throw MotionSensorError.unavailable(.magnetometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startMagnetometerUpdates(to: OperationQueue()) { (data, _) in
				if let data = data {
					let magneticField: MagneticField = .init(
						x: data.magneticField.x,
						y: data.magneticField.y,
						z: data.magneticField.z
					)
					
					continuation.yield(magneticField)
				} else {
					continuation.finish()
				}
			}
		}
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
	
	/// Updates the magnetometer frequency.
	private func updateMagnetometer(to frequency: Measure<Frequency>) {
		self.motionManager.magnetometerUpdateInterval = frequency.converted(to: .second).value
	}
}

#endif
