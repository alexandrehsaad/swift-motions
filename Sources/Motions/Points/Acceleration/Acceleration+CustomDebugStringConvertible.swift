// Acceleration+CustomDebugStringConvertible.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Acceleration: CustomDebugStringConvertible {
	public var debugDescription: String {
		return "x: \(self.x), y: \(self.y), z: \(self.z)"
	}
}
