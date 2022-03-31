// MotionManager.swift
// Motions
//
// Copyright © 2021 Alexandre H. Saad
//

#if !os(macOS) && canImport(CoreMotion)

import CoreMotion

/// A reprensentation of the motion manager.
public final class MotionManager {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance.
	private init() {}
	
	/// The underlying motion manager from Apple's CoreMotion framework.
	private let motionManager: CMMotionManager = .init()
	
	/// The shared instance.
	public static let shared: MotionManager = .init()
	
	// MARK: - Sensors Authorizations
	
	///
	public var authorizationStatus: AuthorizationStatus {
		if #available(iOS 11, macCatalyst 13.1, watchOS 4, *) {
			return CMSensorRecorder.authorizationStatus().clone
		} else {
			let status: Bool = CMSensorRecorder.isAuthorizedForRecording()
			
			switch status {
			case true:
				return .authorized
			case false:
				return .unknown
			}
		}
	}
	
	/// A boolean value indicating whether the user has authorized to be recorded.
	public var isRecordingAuthorized: Bool {
		if #available(iOS 11, macCatalyst 13.1, watchOS 4, *) {
			return self.authorizationStatus.isAuthorized
		} else {
			return CMSensorRecorder.isAuthorizedForRecording()
		}
	}
	
	// MARK: - Sensors Availabilities
	
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
	
	// MARK: - Sensors Activities
	
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
	
	// MARK: - Sensors Frequencies
	
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
	
	// MARK: - Subscribing to Sensors
	
	/// Subscribes to the accelerometer.
	///
	/// - Returns: An asynchronous stream of data from the accelerometer.
	/// - Throws: A motion sensor error.
	@available(iOS 13, macCatalyst 15, macOS 12, watchOS 8, *)
	public func subscribeToAccelerometer() throws -> AsyncStream<Acceleration> {
		guard self.isAccelerometerAvailable else {
			throw MotionSensorError.unavailable(.accelerometer)
		}
		
		guard self.isAccelerometerActive == false && self.areAllSensorsActive == false else {
			throw MotionSensorError.unresubscribable(.accelerometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startAccelerometerUpdates(to: .init()) { (data, _) in
				guard let data: CMAccelerometerData = data else {
					continuation.finish()
					return
				}
				
				let acceleration: Acceleration = .init(
					x: data.acceleration.x,
					y: data.acceleration.y,
					z: data.acceleration.z
				)
				
				continuation.yield(acceleration)
			}
		}
	}
	
	/// Subscribes to the gyrometer.
	///
	/// - Returns: An asynchronous stream of data from the gyrometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macCatalyst 15, macOS 12, watchOS 8, *)
	public func subscribeToGyrometer() throws -> AsyncStream<RotationRate> {
		guard self.isGyrometerAvailable else {
			throw MotionSensorError.unavailable(.gyrometer)
		}
		
		guard self.isGyrometerActive == false && self.areAllSensorsActive == false else {
			throw MotionSensorError.unresubscribable(.gyrometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startGyroUpdates(to: .init()) { (data, _) in
				guard let data: CMGyroData = data else {
					continuation.finish()
					return
				}
				
				let rotationRate: RotationRate = .init(
					x: data.rotationRate.x,
					y: data.rotationRate.y,
					z: data.rotationRate.z
				)
				
				continuation.yield(rotationRate)
			}
		}
	}
	
	/// Subscribes to the magnetometer.
	///
	/// - Returns: An asynchronous stream of data from the magnetometer.
	/// - Throws: A motion sensor error.
	@available(iOS 15, macCatalyst 15, macOS 12, watchOS 8, *)
	public func subscribeToMagnetometer() throws -> AsyncStream<MagneticField> {
		guard self.isMagnetometerAvailable else {
			throw MotionSensorError.unavailable(.magnetometer)
		}
		
		guard self.isMagnetometerActive == false && self.areAllSensorsActive == false else {
			throw MotionSensorError.unresubscribable(.magnetometer)
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startMagnetometerUpdates(to: .init()) { (data, _) in
				guard let data: CMMagnetometerData = data else {
					continuation.finish()
					return
				}
				
				let magneticField: MagneticField = .init(
					x: data.magneticField.x,
					y: data.magneticField.y,
					z: data.magneticField.z
				)
				
				continuation.yield(magneticField)
			}
		}
	}
	
	/// Subscribes to all sensors.
	@available(iOS 15, macCatalyst 15, macOS 12, watchOS 8, *)
	public func subscribeToAllSensors() throws -> AsyncStream<MotionData> {
		guard self.areAllSensorsAvailable else {
			throw MotionSensorError.unavailable()
		}
		
		// Block device motion updates.
		guard self.areAnySensorsActive == false else {
			throw MotionSensorError.unresubscribable()
		}
		
		guard self.areAllFrequenciesEqual else {
			throw MotionSensorError.unequalFrequencies
		}

		return AsyncStream { (continuation) in
			self.motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: .init()) { (data, _) in
				guard let data: CMDeviceMotion = data else {
					continuation.finish()
					return
				}
				
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
				
				let motion: MotionData = .init(
					acceleration: acceleration,
					magneticField: magneticField,
					rotationRate: rotationRate
				)
				
				continuation.yield(motion)
			}
		}
	}
	
	// MARK: - Unsubscribing from Sensors
	
	/// Unsubscribes from the accelerometer.
	///
	/// - Throws: A motion sensor error.
	public func unsubscribeFromAccelerometer() {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			self.motionManager.stopAccelerometerUpdates()
		}
	}
	
	/// Unsubscribes from the gyrometer.
	///
	/// - Throws: A motion sensor error.
	public func unsubscribeFromGyrometer() {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			self.motionManager.stopGyroUpdates()
		}
	}
	
	/// Unsubscribes from the magnetometer.
	///
	/// - Throws: A motion sensor error.
	public func unsubscribeFromMagnetometer() {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			self.motionManager.stopMagnetometerUpdates()
		}
	}
	
	/// Unsubscribes from all sensors.
	public func unsubscribeFromAllSensors() {
		if self.motionManager.isDeviceMotionActive {
			// Stop device motion updates.
			self.motionManager.stopDeviceMotionUpdates()
		} else {
			self.unsubscribeFromAccelerometer()
			self.unsubscribeFromGyrometer()
			self.unsubscribeFromMagnetometer()
		}
	}
	
	// MARK: - Updating Frequencies
	
	/// Updates the accelerometer frequency.
	public func updateAccelerometer(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.accelerometerUpdateInterval = interval
		
		if self.areAllFrequenciesEqual {
			// Update device motion frequency.
			self.motionManager.deviceMotionUpdateInterval = interval
		}
	}
	
	/// Updates the gyrometer frequency.
	public func updateGyrometer(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.gyroUpdateInterval = interval
		
		if self.areAllFrequenciesEqual {
			// Update device motion frequency.
			self.motionManager.deviceMotionUpdateInterval = interval
		}
	}
	
	/// Updates the magnetometer frequency.
	public func updateMagnetometer(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.magnetometerUpdateInterval = interval
		
		if self.areAllFrequenciesEqual {
			// Update device motion frequency.
			self.motionManager.deviceMotionUpdateInterval = interval
		}
	}
	
	/// Updates all sensors frequency.
	///
	/// - Parameter frequency: The new frequency.
	public func updateAllSensors(to frequency: Measure<Frequency>) {
		self.updateAccelerometer(to: frequency)
		self.updateGyrometer(to: frequency)
		self.updateMagnetometer(to: frequency)
	}
}

#endif
