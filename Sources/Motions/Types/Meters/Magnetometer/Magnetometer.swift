// Magnetometer.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

#if !os(macOS) && canImport(CoreMotion)

import CoreMotion

/// A representation of the magnetometer.
@available(iOS 13, macCatalyst 15, macOS 10.5, watchOS 6, *)
public final class Magnetometer {
	/// The underlying motion manager from Apple's CoreMotion framework.
	private let motionManager: CMMotionManager = .init()
	
	// MARK: - Creating Instances
	
	/// Creates a new instance with the desired frequency.
	///
	/// - parameter frequency: The desired frequency.
	public init(frequency: Measure<Frequency> = .init(60, .hertz)) {
		self.update(to: frequency)
	}
	
	deinit {
		self.unsubscribe()
	}
	
	// MARK: - Checking Availabilities
	
	/// A boolean value indicating whether the magnetometer is available.
	public var isAvailable: Bool {
		return self.motionManager.isMagnetometerAvailable
	}
	
	// MARK: - Subscribing to Streams
	
	/// A boolean value indicating whether the magnetometer is active.
	public var isActive: Bool {
		return self.motionManager.isMagnetometerActive
	}
	
	/// Subscribes to the magnetometer.
	///
	/// - throws: A service not available error.
	/// - throws: A service not authorized error.
	/// - returns: An asynchronous stream of data from the magnetometer.
	public func subscribe() throws -> AsyncStream<Point> {
		guard self.isAvailable else {
			throw ServiceError.notAvailable
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
				
				let magneticField: Point = .init(
					x: data.magneticField.x,
					y: data.magneticField.y,
					z: data.magneticField.z
				)
				
				continuation.yield(magneticField)
			}
			
			continuation.onTermination = { @Sendable (termination) in
				switch termination {
				case .cancelled:
					print("Magnetometer stream was cancelled.")
				case .finished:
					print("Magnetometer stream was finished.")
				@unknown default:
					fatalError()
				}
				
				self.motionManager.stopMagnetometerUpdates()
			}
		}
	}
	
	// MARK: - Unsubscribing from Streams
	
	/// Unsubscribes from the magnetometer.
	public func unsubscribe() {
		self.motionManager.stopMagnetometerUpdates()
	}
	
	// MARK: - Updating Frequency
	
	/// The cycles per second at which to deliver magnetometer data.
	public var frequency: Measure<Frequency> {
		let value: Double = self.motionManager.magnetometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// Updates the magnetometer frequency.
	public func update(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.magnetometerUpdateInterval = interval
	}
}

#endif
