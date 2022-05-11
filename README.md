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

3. Import the package in your source code.

    ```swift
    import Motions
    ```
    
## Demonstration

1. Initiate the manager once.

    ```swift
    let manager: MotionManager = .shared
    ```

2. Subscribe to the accelerometers, gyrometers and the magnetometer, and do something with the asynchronous stream of values you receive. The return type is `Point` representing acceleration, rotation or magnetic field respectively, and conforming to a new protocol `PlottableInThreeDimensions`.

    ```swift
    do {
        let stream: AsyncStream<Point> = try manager.subscribeToAccelerometers()
        for await data in stream {
            // Do something with the data.
            print(data)
        }
    } catch let error {
        // Do something with the error.
        print(error)
    }
    ```

3. Unsubscribe from the meters.

    ```swift
    manager.unsubscribeFromAccelerometers()
    ```

### Troubleshooting common errors

Your app must include usage description keys in its `Info.plist` file for the types of data it needs. Failure to include these keys cause the app to crash. To access motion data specifically, it must include `NSMotionUsageDescription`.

## Documentation

You can read more about this package by visiting the [documentation page].

## Contribution

Contributions are what makes the open source community such an amazing place to learn, inspire, and create. If you wish to contribute and be part of this project, please fork the repository and create a [pull request].

1. Fork the repository
2. Create your feature branch `git checkout -b feature/NewFeature`
3. Commit your changes `git commit -m 'Added a new feature'`
4. Push to your branch `git push origin feature/NewFeature`
5. Open a pull request

### Reporting a bug

If you find a bug, please create an [issue].

### Contacting the maintainers

The current code owner of this repository is Alex ([@alexandrehsaad]). If you want to share your thoughts or feedback on how to improve this repository, you can contact him by writing an email to alexandresaad at icloud dot com.

### Supporting this repository

If this repository has been useful to you in some way, show your support by starring it.

## Code of Conduct

To be a truly great community, we welcome developers from all walks of life, with different backgrounds, and with a wide range of experience. A diverse and friendly community will have more great ideas, more unique perspectives, and produce more great code. We will work diligently to make this community welcoming to everyone. See the `CODE_OF_CONDUCT.md` file for more information.

## License

Distributed under Apache License v2.0 with Runtime Library Exception. See the `LICENSE.md` file for more information.

[documentation page]: https://alexandrehsaad.github.io/swift-motions/documentation/motions
[pull request]: https://github.com/alexandrehsaad/swift-motions/pulls
[issue]: https://github.com/alexandrehsaad/swift-motions/issues
[@alexandrehsaad]: https://github.com/alexandrehsaad
