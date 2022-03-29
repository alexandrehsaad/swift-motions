// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "swift-motion",
    defaultLocalization: "en",
    products: [
        .library(name: "Motion", targets: ["Motion"])
    ], dependencies: [
		.package(url: "https://github.com/alexandrehsaad/swift-extensions", branch: "main")
	], targets: [
		.target(name: "Motion", dependencies: [
			.product(name: "Extensions", package: "swift-extensions"),
		]),
	], swiftLanguageVersions: [.v5]
)
