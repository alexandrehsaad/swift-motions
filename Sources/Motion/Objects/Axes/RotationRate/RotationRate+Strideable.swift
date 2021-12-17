// RotationRate+Strideable.swift
// Motion
//
// Copyright © 2021 Alexandre H. Saad
//

extension RotationRate: Strideable {
	public typealias Stride = Double
	
	public func advanced(by n: Self.Stride) -> Self {
		let x: Double = self.x + n
		let y: Double = self.y + n
		let z: Double = self.z + n
		
		return .init(x: x, y: y, z: z)
	}
	
	public func distance(to other: Self) -> Self.Stride {
		let x: Double = other.x - self.x
		let y: Double = other.y - self.y
		let z: Double = other.z - self.z
		
		return (x.squared() + y.squared() + z.squared()).squareRoot()
	}
}
