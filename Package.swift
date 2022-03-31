// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "swift-motions",
    defaultLocalization: "en",
	platforms: [
		.iOS(.v9),
		.macCatalyst(.v13),
		.macOS(.v10_15),
		.watchOS(.v2)
	],
    products: [
        .library(name: "Motions", targets: ["Motions"])
    ],
	dependencies: [
		.package(url: "https://github.com/alexandrehsaad/swift-extensions", branch: "main")
	],
	targets: [
		.target(name: "Motions", dependencies: [
			.product(name: "Extensions", package: "swift-extensions"),
		]),
	],
	swiftLanguageVersions: [.v5]
)
