// MotionManagerDataSource.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

/// A representation of a motion manager data source.
public enum MotionManagerDataSource: Codable {
	/// Recordings from a simulator.
	case simulator
	
	/// Recordings from earbuds.
	@available(*, unavailable)
	case buds
	
	/// Recordings from the iPad.
	@available(*, unavailable)
	case pad
	
	/// Recordings from the iPhone.
	case phone
	
	/// Recordings from the Apple Watch.
	case watch
	
	#if !os(macOS)
	/// The current source.
	static var current: Self {
		#if targetEnvironment(simulator)
		return .simulator
		#elseif os(iOS)
		return .phone
		#elseif os(watchOS)
		return .watch
		#endif
	}
	#endif
}
