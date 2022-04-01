# swift-motions

A wrapper on the CoreMotion framework replacing the completion blocks with Swift concurrency.

## Installation

1. Add the package to the dependencies in your `Package.swift` file.

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/alexandrehsaad/swift-motions.git", branch: "main")
    ],
    ...
)
```

2. Add the package as a dependency on your target in your `Package.swift` file.

```swift
let package = Package(
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

4. Initiate the manager once.

```swift
let manager: MotionManager = .shared
```

5. Subscribe to meters and do something with the asynchronous stream of values you receive. The return type from the accelerometers is `Acceleration`, the gyrometers is `RotationRate` and the magnetometers is `MagneticField`. All three data types conform to `PlottableInThreeDimensions`.

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

6. Unsubscribe from the meters.

```swift
manager.unsubscribeFromAccelerometers()
```

## Troubleshooting

Your app must include usage description keys in its `Info.plist` file for the types of data it needs. Failure to include these keys cause the app to crash. To access motion data specifically, it must include `NSMotionUsageDescription`.

## Roadmap

You can use this framework to access raw data from the user's accelerometers, gyrometers and magnetometers. It could be extended to support a processed version of that data.

## Contribution

### Reporting a bug

If you find a bug, please create an issue.

### Contacting the maintainers

The current code owner of this repository is Alexandre H. Saad ([@alexandrehsaad](https://github.com/alexandrehsaad)). You can contact him by writing an email to alexandresaad at icloud dot com.

## Support

If you like my work, show your support by staring this repository.
 
## Feedback

I would love to hear your thoughts or feedback on how Swift Motions could be improved!
