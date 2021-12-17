// Acceleration+CustomDebugStringConvertible.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension Acceleration: CustomDebugStringConvertible {
	public var debugDescription: String {
		return "x: \(self.x), y: \(self.y), z: \(self.z)"
	}
}
