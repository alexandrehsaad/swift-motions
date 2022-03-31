// AuthorizationStatus.swift
// Motion
//
// Copyright © 2022 Alexandre H. Saad
//

/// A representation of a motion manager authorization status.
public enum AuthorizationStatus {
	/// The status has not yet been determined.
	case undetermined
	
	/// Access is denied and restricted by the device.
	case restricted
	
	/// Access is denied by the user.
	case denied
	
	/// Access is authorized by the user.
	case authorized
}

#if canImport(CoreMotion)

import CoreLocation

@available(iOS 11.0, macOS 10.5, watchOS 4, *)
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
