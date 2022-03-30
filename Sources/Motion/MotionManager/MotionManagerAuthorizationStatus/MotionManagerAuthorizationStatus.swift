// MotionManagerAuthorizationStatus.swift
// Motion
//
// Copyright © 2022 Alexandre H. Saad
//

/// A representation of a motion manager authorization status.
public enum MotionManagerAuthorizationStatus {
	/// The status has not yet been determined.
	case undetermined
	
	/// Access is denied and restricted by the device.
	case restricted
	
	/// Access is denied by the user.
	case denied
	
	/// Access is authorized by the user.
	case authorized
}
