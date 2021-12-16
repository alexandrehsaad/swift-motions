// MagneticField+Hashable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension MagneticField: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.x)
		hasher.combine(self.y)
		hasher.combine(self.z)
	}
}
