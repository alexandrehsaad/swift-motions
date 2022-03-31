// MotionDataCodingKeys.swift
// Motions
//
// Copyright © 2021 Alexandre H. Saad
//

extension MotionData {
	/// The coding keys for the codable protocol.
	internal enum MotionDataCodingKeys: String, CodingKey {
		case acceleration
		case magneticField
		case rotationRate
	}
}
