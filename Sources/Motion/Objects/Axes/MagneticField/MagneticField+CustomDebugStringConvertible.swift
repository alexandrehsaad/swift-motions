// MagneticField+CustomDebugStringConvertible.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension MagneticField: CustomDebugStringConvertible {
	public var debugDescription: String {
		return "x: \(self.x), y: \(self.y), z: \(self.z)"
	}
}
