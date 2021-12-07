// Acceleration+CustomDebugStringConvertible.swift
// MotionKit
//
// Copyright © 2021 A. H. de Quatre Ltd.
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Acceleration: CustomDebugStringConvertible {
	public var debugDescription: String {
		return "x: \(self.x), y: \(self.y), z: \(self.z)"
	}
}