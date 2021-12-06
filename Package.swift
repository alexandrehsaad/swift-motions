// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "motion-kit",
    defaultLocalization: "en",
    products: [
        .library(name: "MotionKit", targets: ["MotionKit"])
    ], targets: [
        .target(name: "MotionKit", dependencies: []),
        .testTarget(name: "MotionKitTests", dependencies: ["MotionKit"]),
    ], swiftLanguageVersions: [.version("5.5")]
)
