![](Assets/GitHubBanner.png)

# swift-motions

A wrapper on the CoreMotion framework replacing the completion blocks with Swift concurrency.

## Overview

CoreMotion reports motion and environment related data from the accelerometers, gyrometers, magnetometer and barometer on iOS devices.

## Availability

- iOS 13.0+
- iPadOS 13.0+
- macCatalyst 15.0+
- macOS 10.15+
- watchOS 6.0+

## Installation

The Swift Package Manager is a tool for managing the distribution of Swift code and is integrated into the swift compiler.

1. Add the package to the dependencies in your `Package.swift` file.

```swift
let package: Package = .init(
    ...
    dependencies: [
        .package(url: "https://github.com/alexandrehsaad/swift-motions.git", branch: "main")
    ],
    ...
)
```

2. Add the package as a dependency on your target in your `Package.swift` file.

```swift
let package: Package = .init(
    ...
    targets: [
        .target(name: "MyTarget", dependencies: [
            .product(name: "Motions", package: "swift-motions")
        ]),
    ],
    ...
)
```

## Demonstration

1. Import the package in your source code.

```swift
import Motions
```

2. Initiate the manager once.

```swift
let manager: MotionManager = .shared
```

3. Subscribe to meters and do something with the asynchronous stream of values you receive. The return type from the accelerometers is `Acceleration`, the gyrometers is `RotationRate` and the magnetometer is `MagneticField`. All three data types conform to `PlottableInThreeDimensions`.

```swift
do {
    let stream: AsyncStream<Acceleration> = try manager.subscribeToAccelerometers()
    for await data in stream {
        // Do something with the data.
        print(data)
    }
} catch let error {
    // Do something with the error.
    print(error)
}
```

4. Unsubscribe from the meters.

```swift
manager.unsubscribeFromAccelerometers()
```

## Troubleshooting

Your app must include usage description keys in its `Info.plist` file for the types of data it needs. Failure to include these keys cause the app to crash. To access motion data specifically, it must include `NSMotionUsageDescription`.

## Roadmap

You can use this framework to access raw data from the user's accelerometers, gyrometers and magnetometer. It could be extended to support a processed version of that data; and support the barometer.

## Contribution

Contributions are what makes the open source community such an amazing place to learn, inspire, and create. If you wish to contribute and be part of this project, please fork the repository and create a [pull request](https://github.com/alexandrehsaad/swift-motions/pulls).

1. Fork the repository
2. Create your feature branch `git checkout -b NewFeature`
3. Commit your changes `git commit -m 'Added a new feature'`
4. Push to your branch `git push origin NewFeature`
5. Open a pull request

### Reporting a bug

If you find a bug, please create an [issue](https://github.com/alexandrehsaad/swift-motions/issues).

### Contacting the maintainers

The current code owner of this repository is Alex ([@alexandrehsaad](https://github.com/alexandrehsaad)). If you want to share your thoughts or feedback on how to improve this repository, you can contact him by writing an email to alexandresaad at icloud dot com.

### Supporting this repository

If this repository has been useful to you in some way, show your support by starring it.

## License

Distributed under Apache License v2.0 with Runtime Library Exception. See the `LICENSE.txt` file for more information.
