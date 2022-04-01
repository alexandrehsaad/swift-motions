// MotionManager.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

#if !os(macOS) && canImport(CoreMotion)

import CoreMotion

/// A representation of the motion manager.
@available(iOS 13, macCatalyst 15, macOS 10.5, watchOS 6, *)
public final class MotionManager {
	/// The underlying motion manager from Apple's CoreMotion framework.
	private let motionManager: CMMotionManager = .init()
	
	// MARK: - Creating Instances
	
	/// Creates a new instance.
	private init() {}
	
	/// The shared instance.
	public static let shared: MotionManager = .init()
	
	deinit {
		self.unsubscribeFromAllMeters()
	}
	
	// MARK: - Checking Availabilities
	
	/// A boolean value indicating whether the accelerometers are available.
	public var areAccelerometersAvailable: Bool {
		return self.motionManager.isAccelerometerAvailable
	}
	
	/// A boolean value indicating whether the gyrometers are available.
	public var areGyrometersAvailable: Bool {
		return self.motionManager.isGyroAvailable
	}
	
	/// A boolean value indicating whether the magnetometers are available.
	public var areMagnetometersAvailable: Bool {
		return self.motionManager.isMagnetometerAvailable
	}
	
	/// A boolean value indicating whether all meters are available.
	public var areAllMetersAvailable: Bool {
		return self.motionManager.isDeviceMotionAvailable
	}
	
	// MARK: - Requesting Authorizations
	
	/// The app’s authorization status for using motion services.
	public private(set) var authorizationStatus: AuthorizationStatus = .undetermined
	
	/// A boolean value indicating whether the user has authorized to share his motion.
	public var isAuthorizedToRecord: Bool {
		return self.authorizationStatus.isAuthorized
	}
	
	/// Requests the user’s permission to use motion services.
	///
	/// - throws: An authorization not changeable error.
	/// - returns: A discardable authorization status.
	@discardableResult
	public func requestAuthorization() async throws -> AuthorizationStatus {
		guard self.authorizationStatus == .undetermined else {
			throw ServiceError.notChangeable
		}
		
		return try await withCheckedThrowingContinuation { (continuation) in
			self.motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
				self.motionManager.stopAccelerometerUpdates()
				
				// FIXME: better handle errors from the callback
				if let error = error {
					print(error.localizedDescription)
					continuation.resume(throwing: error)
				} else if data != nil {
					print("Motion services were authorized.")
					continuation.resume(returning: .authorized)
				}
			}
		}
	}
	
	// MARK: - Subscribing to Streams
	
	/// A boolean value indicating whether the accelerometers are active.
	public var areAccelerometersActive: Bool {
		return self.motionManager.isAccelerometerActive
	}
	
	/// A boolean value indicating whether the gyrometers are active.
	public var areGyrometersActive: Bool {
		return self.motionManager.isGyroActive
	}
	
	/// A boolean value indicating whether the magnetometers are active.
	public var areMagnetometersActive: Bool {
		return self.motionManager.isMagnetometerActive
	}
	
	/// A boolean value indicating whether all meters are active.
	public var areAllMetersActive: Bool {
		return (self.areGyrometersActive && self.areMagnetometersActive && self.areAllMetersActive)
			|| self.motionManager.isDeviceMotionActive
	}
	
	/// A boolean value indicating whether any meters are active.
	public var areAnyMetersActive: Bool {
		return self.areAccelerometersActive
			|| self.areGyrometersActive
			|| self.areMagnetometersActive
			|| self.motionManager.isDeviceMotionActive
	}
	
	/// Subscribes to the accelerometers.
	///
	/// - throws: A service not available error.
	/// - throws: A service not authorized error.
	/// - returns: An asynchronous stream of data from the accelerometers.
	public func subscribeToAccelerometers() throws -> AsyncStream<Acceleration> {
		guard self.areAccelerometersAvailable else {
			throw ServiceError.notAvailable
		}
		
		guard self.isAuthorizedToRecord else {
			throw ServiceError.notAuthorized
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startAccelerometerUpdates(to: .init()) { (data, error) in
				// FIXME: better handle errors from the callback
				if let error = error {
					print(error.localizedDescription)
					continuation.finish()
					return
				}
				
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
			
			continuation.onTermination = { @Sendable (termination) in
				switch termination {
				case .cancelled:
					print("Accelerometers stream was cancelled.")
				case .finished:
					print("Accelerometers stream was finished.")
				@unknown default:
					fatalError()
				}
				
				self.motionManager.stopAccelerometerUpdates()
			}
		}
	}
	
	/// Subscribes to the gyrometers.
	///
	/// - throws: A service not available error.
	/// - throws: A service not authorized error.
	/// - returns: An asynchronous stream of data from the gyrometers.
	public func subscribeToGyrometers() throws -> AsyncStream<RotationRate> {
		guard self.areGyrometersAvailable else {
			throw ServiceError.notAvailable
		}
		
		guard self.isAuthorizedToRecord else {
			throw ServiceError.notAuthorized
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startGyroUpdates(to: .init()) { (data, error) in
				// FIXME: better handle errors from the callback
				if let error = error {
					print(error.localizedDescription)
					continuation.finish()
					return
				}
				
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
			
			continuation.onTermination = { @Sendable (termination) in
				switch termination {
				case .cancelled:
					print("Gyrometers stream was cancelled.")
				case .finished:
					print("Gyrometers stream was finished.")
				@unknown default:
					fatalError()
				}
				
				self.motionManager.stopGyroUpdates()
			}
		}
	}
	
	/// Subscribes to the magnetometers.
	///
	/// - throws: A service not available error.
	/// - throws: A service not authorized error.
	/// - returns: An asynchronous stream of data from the magnetometers.
	public func subscribeToMagnetometers() throws -> AsyncStream<MagneticField> {
		guard self.areMagnetometersAvailable else {
			throw ServiceError.notAvailable
		}
		
		guard self.isAuthorizedToRecord else {
			throw ServiceError.notAuthorized
		}
		
		return AsyncStream { (continuation) in
			self.motionManager.startMagnetometerUpdates(to: .init()) { (data, error) in
				// FIXME: better handle errors from the callback
				if let error = error {
					print(error.localizedDescription)
					continuation.finish()
					return
				}
				
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
			
			continuation.onTermination = { @Sendable (termination) in
				switch termination {
				case .cancelled:
					print("Magnetometers stream was cancelled.")
				case .finished:
					print("Magnetometers stream was finished.")
				@unknown default:
					fatalError()
				}
				
				self.motionManager.stopMagnetometerUpdates()
			}
		}
	}
	
	/// Subscribes to all meters.
	///
	/// - throws: A service not available error.
	/// - throws: A service not authorized error.
	/// - returns: An asynchronous stream of data from all the meters.
	@available(*, unavailable)
	public func subscribeToAllMeters() throws -> AsyncStream<(Acceleration, RotationRate, MagneticField)> {
		guard self.areAllMetersAvailable else {
			throw ServiceError.notAvailable
		}
		
		guard self.isAuthorizedToRecord else {
			throw ServiceError.notAuthorized
		}
		
		return AsyncStream { (continuation) in
			// TODO: subscribe to all meters
			
			continuation.onTermination = { @Sendable (termination) in
				switch termination {
				case .cancelled:
					print("All meters streams were cancelled.")
				case .finished:
					print("All meters streams were finished.")
				@unknown default:
					fatalError()
				}
				
				self.motionManager.stopDeviceMotionUpdates()
			}
		}
	}
	
	// MARK: - Unsubscribing from Streams
	
	/// Unsubscribes from the accelerometer.
	public func unsubscribeFromAccelerometers() {
		self.motionManager.stopAccelerometerUpdates()
	}
	
	/// Unsubscribes from the gyrometers.
	public func unsubscribeFromGyrometers() {
		self.motionManager.stopGyroUpdates()
	}
	
	/// Unsubscribes from the magnetometers.
	public func unsubscribeFromMagnetometers() {
		self.motionManager.stopMagnetometerUpdates()
	}
	
	/// Unsubscribes from all meters.
	public func unsubscribeFromAllMeters() {
		self.unsubscribeFromAccelerometers()
		self.unsubscribeFromGyrometers()
		self.unsubscribeFromMagnetometers()
	}
	
	// MARK: - Meters Frequencies
	
	/// The cycles per second at which to deliver accelerometer data.
	public var accelerometersFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.accelerometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// The cycles per second at which to deliver gyrometer data.
	public var gyrometersFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.gyroUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// The cycles per second at which to deliver magnetometer data.
	public var magnetometersFrequency: Measure<Frequency> {
		let value: Double = self.motionManager.magnetometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// A boolean value indicating whether all frequencies are equal.
	private var areAllFrequenciesEqual: Bool {
		let frequencies: [Measure<Frequency>] = [
			self.accelerometersFrequency,
			self.gyrometersFrequency,
			self.magnetometersFrequency
		]
		
		return frequencies.areEqual
	}
	
	// MARK: - Updating Frequencies
	
	/// Updates the accelerometers frequency.
	public func updateAccelerometers(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.accelerometerUpdateInterval = interval
	}
	
	/// Updates the gyrometers frequency.
	public func updateGyrometers(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.gyroUpdateInterval = interval
	}
	
	/// Updates the magnetometers frequency.
	public func updateMagnetometers(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.magnetometerUpdateInterval = interval
	}
	
	/// Updates all meters frequency.
	///
	/// - Parameter frequency: The new frequency.
	public func updateAllMeters(to frequency: Measure<Frequency>) {
		self.updateAccelerometers(to: frequency)
		self.updateGyrometers(to: frequency)
		self.updateMagnetometers(to: frequency)
	}
}

#endif
