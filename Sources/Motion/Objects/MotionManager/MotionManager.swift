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
	
	/// The underlying motion manager from Apple's CoreMotion framework.
	private let motionManager: CMMotionManager = .init()
	
	/// The shared instance.
	public static let shared: MotionManager = .init()
	
	// MARK: - Get sensors activity
	
	/// A boolean value indicating whether the accelerometer is active.
	public var isAccelerometerActive: Bool {
		return self.motionManager.isAccelerometerActive
	}
	
	/// A boolean value indicating whether the gyrometer is active.
	public var isGyrometerActive: Bool {
		return self.motionManager.isGyroActive
	}
	
	/// A boolean value indicating whether the magnetometer is active.
	public var isMagnetometerActive: Bool {
		return self.motionManager.isMagnetometerActive
	}
	
	/// A boolean value indicating whether all sensors are active.
	public var areAllSensorsActive: Bool {
		return (self.isGyrometerActive && self.isMagnetometerActive && self.areAllSensorsActive)
			|| self.motionManager.isDeviceMotionActive
	}
	
	/// A boolean value indicating whether any sensors are active.
	public var areAnySensorsActive: Bool {
		return self.isAccelerometerActive
			|| self.isGyrometerActive
			|| self.isMagnetometerActive
			|| self.motionManager.isDeviceMotionActive
	}
	
	// MARK: - Get sensors availability
	
	/// A boolean value indicating whether the accelerometer is available.
	public var isAccelerometerAvailable: Bool {
		return self.motionManager.isAccelerometerAvailable
	}
	
	/// A boolean value indicating whether the gyrometer is available.
	public var isGyrometerAvailable: Bool {
		return self.motionManager.isGyroAvailable
	}
	
	/// A boolean value indicating whether the magnetometer is available.
	public var isMagnetometerAvailable: Bool {
		return self.motionManager.isMagnetometerAvailable
	}
	
	/// A boolean value indicating whether all sensors are available.
	public var areAllSensorsAvailable: Bool {
		return self.motionManager.isDeviceMotionAvailable
	}
	
	// MARK: - Get sensors frequency
	
	/// A boolean value indicating whether all frequencies are equal.
	private var areAllFrequenciesEqual: Bool {
		let frequencies: [Measure<Frequency>] = [
			self.accelerometerFrequency,
			self.gyrometerFrequency,
			self.magnetometerFrequency
		]
		
		return frequencies.areEqual
	}
	
	/// The cycles per second at which to deliver accelerometer data.
	public var accelerometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.accelerometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// The cycles per second at which to deliver gyrometer data.
	public var gyrometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.gyroUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// The cycles per second at which to deliver magnetometer data.
	public var magnetometerFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.magnetometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	// MARK: - Subscribe to sensors
	
	/// Subscribes to the accelerometer.
	///
	/// - Returns: An asynchronous stream of data from the accelerometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macOS 12, watchOS 8, *)
	public func subscribeToAccelerometer() throws -> AsyncStream<Acceleration> {
		guard self.isAccelerometerAvailable else {
			throw MotionSensorError.unavailable(.accelerometer)
		}
		
		guard self.isAccelerometerActive == false && self.areAllSensorsActive == false else {
			throw MotionSensorError.unresubscribable(.accelerometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startAccelerometerUpdates(to: .init()) { (data, _) in
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
	
	/// Subscribes to the gyrometer.
	///
	/// - Returns: An asynchronous stream of data from the gyrometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macOS 12, watchOS 8, *)
	public func subscribeToGyrometer() throws -> AsyncStream<RotationRate> {
		guard self.isGyrometerAvailable else {
			throw MotionSensorError.unavailable(.gyrometer)
		}
		
		guard self.isGyrometerActive == false && self.areAllSensorsActive == false else {
			throw MotionSensorError.unresubscribable(.gyrometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startGyroUpdates(to: .init()) { (data, _) in
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
	
	/// Subscribes to the magnetometer.
	///
	/// - Returns: An asynchronous stream of data from the magnetometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macOS 12, watchOS 8, *)
	public func subscribeToMagnetometer() throws -> AsyncStream<MagneticField> {
		guard self.isMagnetometerAvailable else {
			throw MotionSensorError.unavailable(.magnetometer)
		}
		
		guard self.isMagnetometerActive == false && self.areAllSensorsActive == false else {
			throw MotionSensorError.unresubscribable(.magnetometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startMagnetometerUpdates(to: .init()) { (data, _) in
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
	
	/// Subscribes to all sensors.
	@available(iOS 15, macOS 12, watchOS 8, *)
	public func subscribeToAllSensors() throws -> AsyncStream<MotionData> {
		guard self.areAllSensorsAvailable else {
			throw MotionSensorError.unavailable()
		}
		
		guard self.areAnySensorsActive == false else {
			throw MotionSensorError.unresubscribable()
		}
		
		guard self.areAllFrequenciesEqual else {
			throw MotionSensorError.unequalFrequencies
		}

		return AsyncStream { (continuation) in
			self.motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: .init()) { (data, _) in
				if let data = data {
					let acceleration: Acceleration = .init(
						x: data.userAcceleration.x,
						y: data.userAcceleration.y,
						z: data.userAcceleration.z
					)
					
					let rotationRate: RotationRate = .init(
						x: data.rotationRate.x,
						y: data.rotationRate.y,
						z: data.rotationRate.z
					)
					
					let magneticField: MagneticField = .init(
						x: data.magneticField.field.x,
						y: data.magneticField.field.y,
						z: data.magneticField.field.z
					)
					
					let data: MotionData = .init(acceleration: acceleration, magneticField: magneticField, rotationRate: rotationRate)
					
					continuation.yield(data)
				} else {
					continuation.finish()
				}
			}
		}
	}
	
	// MARK: - Unsubscribe from sensors
	
	/// Unsubscribes from the accelerometer.
	///
	/// - Throws: A motion sensor error.
	private func unsubscribeFromAccelerometer() throws {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			guard self.isAccelerometerActive else {
				throw MotionSensorError.inactive(.accelerometer)
			}
			
			self.motionManager.stopAccelerometerUpdates()
		}
	}
	
	/// Unsubscribes from the gyrometer.
	///
	/// - Throws: A motion sensor error.
	private func unsubscribeFromGyrometer() throws {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			guard self.isGyrometerActive else {
				throw MotionSensorError.inactive(.gyrometer)
			}
			
			self.motionManager.stopGyroUpdates()
		}
	}
	
	/// Unsubscribes from the magnetometer.
	///
	/// - Throws: A motion sensor error.
	private func unsubscribeFromMagnetometer() throws {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			guard self.isMagnetometerActive else {
				throw MotionSensorError.inactive(.magnetometer)
			}
			
			self.motionManager.stopMagnetometerUpdates()
		}
	}
	
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
	private func unsubscribe(from sensors: Set<MotionSensor>) throws {
		for sensor in sensors {
			try self.unsubscribe(from: sensor)
		}
	}
	
	/// Unsubscribes from all sensors.
	public func unsubscribeFromAllSensors() throws {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			let allSensors: Set<MotionSensor> = .init(MotionSensor.allCases)
			try self.unsubscribe(from: allSensors)
		}
	}
	
	// MARK: - Update sensors frequency
	
	/// Updates the accelerometer frequency.
	private func updateAccelerometer(to frequency: Measure<Frequency>) {
		self.motionManager.accelerometerUpdateInterval = frequency.converted(to: .second).value
		
		if self.areAllFrequenciesEqual {
			// Update device motion frequency.
			self.motionManager.deviceMotionUpdateInterval = frequency.converted(to: .second).value
		}
	}
	
	/// Updates the gyrometer frequency.
	private func updateGyrometer(to frequency: Measure<Frequency>) {
		self.motionManager.gyroUpdateInterval = frequency.converted(to: .second).value
		
		if self.areAllFrequenciesEqual {
			// Update device motion frequency.
			self.motionManager.deviceMotionUpdateInterval = frequency.converted(to: .second).value
		}
	}
	
	/// Updates the magnetometer frequency.
	private func updateMagnetometer(to frequency: Measure<Frequency>) {
		self.motionManager.magnetometerUpdateInterval = frequency.converted(to: .second).value
		
		if self.areAllFrequenciesEqual {
			// Update device motion frequency.
			self.motionManager.deviceMotionUpdateInterval = frequency.converted(to: .second).value
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
	private func update(_ sensors: Set<MotionSensor>, to frequency: Measure<Frequency>) {
		for sensor in sensors {
			self.update(sensor, to: frequency)
		}
	}
	
	/// Updates all sensors frequency.
	///
	/// - Parameter frequency: The new frequency.
	public func updateAllSensors(to frequency: Measure<Frequency>) {
		let allSensors: Set<MotionSensor> = .init(MotionSensor.allCases)
		self.update(allSensors, to: frequency)
	}
}

#endif
