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
	/// The update frequency in herts.
	private let frequency: Measure<Frequency>
	
	/// Creates a new instance.
	///
	/// - Parameter frequency: The update frequency.
	private init(frequency: Measure<Frequency> = .init(60, .hertz)) {
		self.frequency = frequency.converted(to: .hertz)
	}
	
	private let motionManager: CMMotionManager = .init()
	
	public static let shared: MotionManager = .init()
	
//	/// The cancellable subscription of the timer.
//	private var cancellable: AnyCancellable? = nil
	
//	/**
//	 Subcribe to a parrticular motion sensor.
//
//	 - parameter to: the sensor to which we are subscribing.
//	 - parameter handler: the sensor event handler.
//
//	 - throws: MKError.
//
//	 - returns: the current MotionKit instance.
//	 */
//	public func subcribe(
//		_ to: MotionSensor,
//		handler: @escaping (MotionData) -> ()
//	) throws -> Self {
//
//	}
//
//	/**
//	 Set the sampling period for a sensor. Will have no effect on the Altimeter sampling period.
//
//	 - parameter sensor: the sensor for which we are setting the sampling period.
//	 - parameter every: the sampling TimeInterval in seconds.
//
//	 - returns: the current MotionKit instance.
//	 */
//	func update(
//		_ sensor: MotionSensor,
//		every: TimeInterval,
//		_ timeUnit: TimeUnit
//	) -> Self
//
//	/**
//	 Set the sampling period for all motion sensors (except Altimeter).
//
//	 - parameter every: the sampling TimeInterval in seconds.
//
//	 - returns: the current MotionKit instance.
//	 */
//	func updateAll(every: TimeInterval, _ timeUnit: TimeUnit) -> MotionKit
//
//	/**
//	 Set the sampling period for all motion sensors (except the provided list of sensors, and Altimeter).
//
//	 - parameter every: the sampling TimeInterval in seconds.
//	 - parameter except: the list of sensors for which the TimeInterval will not be set.
//
//	 - returns: the current MotionKit instance.
//	 */
//	func updateAll(except: [MotionSensor], every: TimeInterval, _ timeUnit: TimeUnit) -> MotionKit
}

// MARK: - Shared

extension MotionManager {
	/// Subscribes to the specified sensor to start updates.
	///
	/// - Parameter sensor: The sensor to subscribe to.
	/// - Throws: A motion sensor error.
	public func subscribe(to sensor: MotionSensor) throws {
		switch sensor {
		case .accelerometer:
			try self.subscribeToAccelerometer()
			
		case .gyroscope:
			try self.subscribeToGyrometer()
			
		case .magnetometer:
			try self.subscribeToMagnetometer()
		
		@unknown default:
			return
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
			
		case .gyroscope:
			try self.unsubscribeFromGyrometer()
			
		case .magnetometer:
			try self.unsubscribeFromMagnetometer()
		
		@unknown default:
			return
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
	
	/// Subscribes to the accelerometer to start updates.
	///
	/// - Throws: A motion sensor error.
	private func subscribeToAccelerometer() throws {
		guard self.isAccelerometerAvailable else {
			throw MotionSensorError.unavailable(.accelerometer)
		}
		
		self.motionManager.startAccelerometerUpdates()
	}
	
	/// Unsubscribes from the accelerometer to stop updates.
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
	
	/// Subscribes to the gyrometer to start updates.
	///
	/// - Throws: A motion sensor error.
	private func subscribeToGyrometer() throws {
		guard self.isGyrometerAvailable else {
			throw MotionSensorError.unavailable(.gyroscope)
		}
		
		self.motionManager.startGyroUpdates()
	}
	
	/// Unsubscribes from the gyrometer to stop updates.
	///
	/// - Throws: A motion sensor error.
	private func unsubscribeFromGyrometer() throws {
		guard self.isGyrometerActive else {
			throw MotionSensorError.inactive(.gyroscope)
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
	
	/// Subscribes to the magnetometer to start updates.
	///
	/// - Throws: A motion sensor error.
	private func subscribeToMagnetometer() throws {
		guard self.isMagnetometerAvailable else {
			throw MotionSensorError.unavailable(.magnetometer)
		}
		
		self.motionManager.startMagnetometerUpdates()
	}
	
	/// Unsubscribes from the magnetometer to stop updates.
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
