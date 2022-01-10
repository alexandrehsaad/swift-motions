// MotionData+Hashable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionData: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.acceleration)
		hasher.combine(self.magneticField)
		hasher.combine(self.rotationRate)
	}
}
