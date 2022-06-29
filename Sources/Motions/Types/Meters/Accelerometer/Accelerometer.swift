// Accelerometer.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

#if !os(macOS) && canImport(CoreMotion)

import CoreMotion

/// A representation of the accelerometer.
@available(iOS 13, macCatalyst 15, macOS 10.5, watchOS 6, *)
public final class Accelerometer {
	/// The underlying motion manager from Apple's CoreMotion framework.
	private let motionManager: CMMotionManager = .shared
	
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
	
	// MARK: - Checking Availability
	
	/// A boolean value indicating whether the accelerometer is available.
	public var isAvailable: Bool {
		return self.motionManager.isAccelerometerAvailable
	}
	
	// MARK: - Subscribing to Streams
	
	/// A boolean value indicating whether the accelerometer is active.
	public var isActive: Bool {
		return self.motionManager.isAccelerometerActive
	}
	
	/// Subscribes to the accelerometer.
	///
	/// - throws: A service not available error.
	/// - throws: A service not authorized error.
	/// - returns: An asynchronous stream of data from the accelerometers.
	public func subscribe() throws -> AsyncStream<Point> {
		guard self.isAvailable else {
			throw ServiceError.notAvailable
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
				
				let accelerations: Point = .init(
					x: data.acceleration.x,
					y: data.acceleration.y,
					z: data.acceleration.z
				)
				
				continuation.yield(accelerations)
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
	
	// MARK: - Unsubscribing from Streams
	
	/// Unsubscribes from the accelerometer.
	public func unsubscribe() {
		self.motionManager.stopAccelerometerUpdates()
	}
	
	// MARK: - Updating Frequency
	
	/// The cycles per second at which to deliver accelerometer data.
	public var frequency: Measure<Frequency> {
		let value: Double = self.motionManager.accelerometerUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// Updates the accelerometer frequency.
	public func update(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.accelerometerUpdateInterval = interval
	}
}

#endif
