// Rotation+CustomDebugStringConvertible.swift
// MotionKit
//
// Copyright © 2021 A. H. de Quatre Ltd.
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Rotation: CustomDebugStringConvertible {
	public var description: String {
		return "x: \(self.x), y: \(self.y), z: \(self.z)"
	}
}
