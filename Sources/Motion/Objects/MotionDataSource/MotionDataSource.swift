// MotionDataSource.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

/// A representation of a motion data source.
public enum MotionDataSource: Codable, Sendable {
	/// Recordings from earbuds.
	@available(*, unavailable)
	case bud
	
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
		#if os(iOS)
		return .phone
		#elseif os(watchOS)
		return .watch
		#endif
	}
	#endif
}
