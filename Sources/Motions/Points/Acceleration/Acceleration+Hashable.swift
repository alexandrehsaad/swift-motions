// Acceleration+Hashable.swift
// Motions
//
// Copyright © 2022 Alexandre H. Saad
//

extension Acceleration: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.x)
		hasher.combine(self.y)
		hasher.combine(self.z)
	}
}
