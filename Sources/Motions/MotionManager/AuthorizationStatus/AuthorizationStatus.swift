// AuthorizationStatus.swift
// Motion
//
// Copyright © 2022 Alexandre H. Saad
//

#if !os(macOS)

/// A representation of a motion manager authorization status.
public enum AuthorizationStatus {
	/// The status is not known.
	@available(iOS, obsoleted: 11)
	@available(macCatalyst, obsoleted: 13.1)
	@available(watchOS, obsoleted: 4)
	case unknown
	
	/// The status has not yet been determined.
	@available(iOS 11, macCatalyst 13.1, watchOS 4, *)
	case undetermined
	
	/// Access is denied and restricted by the device.
	@available(iOS 11, macCatalyst 13.1, watchOS 4, *)
	case restricted
	
	/// Access is denied by the user.
	@available(iOS 11, macCatalyst 13.1, watchOS 4, *)
	case denied
	
	/// Access is authorized by the user.
	case authorized
	
	/// A boolean value indicating whether access is authorized by the user.
	public var isAuthorized: Bool {
		switch self {
		case .authorized:
			return true
		default:
			return false
		}
	}
}

#if canImport(CoreMotion)

import CoreLocation

@available(iOS 11, macCatalyst 13.1, watchOS 4, *)
extension CMAuthorizationStatus {
	///
	internal var clone: AuthorizationStatus {
		switch self {
		case .notDetermined:
			return .undetermined
		case .restricted:
			return .restricted
		case .denied:
			return .denied
		case .authorized:
			return .authorized
		@unknown default:
			fatalError()
		}
	}
}

#endif

#endif
