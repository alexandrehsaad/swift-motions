// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "swift-motion",
    defaultLocalization: "en",
    products: [
        .library(name: "Motion", targets: ["Motion"])
    ], dependencies: [
		.package(name: "swift-measures", url: "https://github.com/alexandrehsaad/swift-measures", branch: "main")
	], targets: [
		.target(name: "Motion", dependencies: [
			.product(name: "Measures", package: "swift-measures"),
		]),
    ], swiftLanguageVersions: [.version("5.5")]
)
