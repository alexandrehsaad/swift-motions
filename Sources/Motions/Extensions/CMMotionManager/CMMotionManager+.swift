// CMMotionManager+.swift
// Motions
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

#if !os(macOS) && canImport(CoreMotion)

import CoreMotion

extension CMMotionManager {
	/// The shared instance.
	internal static let shared: CMMotionManager = .init()
}

#endif
