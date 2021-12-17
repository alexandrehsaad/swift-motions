// Acceleration+Strideable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension Acceleration: Strideable {
	public typealias Stride = Double
	
	public func advanced(by n: Self.Stride) -> Self {
		let x: Double = self.x.value + n
		let y: Double = self.y.value + n
		let z: Double = self.z.value + n
		
		return .init(x: x, y: y, z: z)
	}
	
	public func distance(to other: Self) -> Self.Stride {
		let x: Double = other.x.value - self.x.value
		let y: Double = other.y.value - self.y.value
		let z: Double = other.z.value - self.z.value
		
		return (x.squared() + y.squared() + z.squared()).squareRoot()
	}
}
