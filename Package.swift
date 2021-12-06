// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "motion-kit",
    defaultLocalization: "en",
    products: [
        .library(name: "MotionKit", targets: ["MotionKit"])
    ], dependencies: [
		.package(name: "swift-measures", url: "https://github.com/alexandrehsaad/swift-measures", branch: "main")
	], targets: [
		.target(name: "MotionKit", dependencies: [
			.product(name: "Measures", package: "swift-measures"),
		]),
        .testTarget(name: "MotionKitTests", dependencies: ["MotionKit"]),
    ], swiftLanguageVersions: [.version("5.5")]
)
