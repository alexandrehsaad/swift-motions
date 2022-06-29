// Gyrometer.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

#if !os(macOS) && canImport(CoreMotion)

import CoreMotion

/// A representation of the gyrometer.
@available(iOS 13, macCatalyst 15, macOS 10.5, watchOS 6, *)
public final class Gyrometer {
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
	
	/// A boolean value indicating whether the gyrometer is available.
	public var isAvailable: Bool {
		return self.motionManager.isGyroAvailable
	}
	
	// MARK: - Subscribing to Streams
	
	/// A boolean value indicating whether the gyrometer is active.
	public var isActive: Bool {
		return self.motionManager.isGyroActive
	}
	
	/// Subscribes to the gyrometer.
	///
	/// - throws: A service not available error.
	/// - throws: A service not authorized error.
	/// - returns: An asynchronous stream of data from the gyrometers.
	public func subscribe() throws -> AsyncStream<Point> {
		guard self.isAvailable else {
			throw ServiceError.notAvailable
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
				
				let rotations: Point = .init(
					x: data.rotationRate.x,
					y: data.rotationRate.y,
					z: data.rotationRate.z
				)
				
				continuation.yield(rotations)
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
	
	// MARK: - Unsubscribing from Streams
	
	/// Unsubscribes from the gyrometer.
	public func unsubscribe() {
		self.motionManager.stopGyroUpdates()
	}
	
	// MARK: - Updating Frequency
	
	/// The cycles per second at which to deliver gyrometer data.
	public var frequency: Measure<Frequency> {
		let value: Double = self.motionManager.gyroUpdateInterval
		
		return .init(value, .hertz)
	}
	
	/// Updates the gyrometer frequency.
	public func update(to frequency: Measure<Frequency>) {
		let interval: Double = frequency.converted(to: .second).value
		self.motionManager.gyroUpdateInterval = interval
	}
}

#endif
