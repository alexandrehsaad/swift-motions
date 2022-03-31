// CMAuthorizationStatus+.swift
// Motions
//
// Copyright © 2022 Alexandre H. Saad
//

#if !os(macOS) && canImport(CoreMotion)

import CoreLocation

@available(iOS 11, macCatalyst 13.1, watchOS 4, *)
extension CMAuthorizationStatus {
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
