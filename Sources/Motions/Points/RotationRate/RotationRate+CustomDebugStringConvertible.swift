// RotationRate+CustomDebugStringConvertible.swift
// Motions
//
// Copyright © 2022 Alexandre H. Saad
//

extension RotationRate: CustomDebugStringConvertible {
	public var debugDescription: String {
		return "x: \(self.x), y: \(self.y), z: \(self.z)"
	}
}
