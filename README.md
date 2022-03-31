# swift-motions

A wrapper on the CoreMotion framework replacing the callback pattern with Swift concurrency.

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

## Tutorial

4. Check if your device supports the accelerometer, gyrometer or magnetometer.

```swift
let motionManager: MotionManager = .shared

let _: Bool = motionManager.isAccelerometerAvailable
// Prints "true"
```

5. Subscribe to a sensor and do something with the asynchronous stream of values 
you receive from moving your device.

```swift
Task {
    for await acceleration in try motionManager.subscribeToAccelerometer() {
        // Do something with the data of type Acceleration, conforming to the custom protocol PlottableInThreeDimensions.
    }
}
```

6. Unsubscribe from the sensor.

```swift
motionManager.unsubscribeFromAccelerometer()

let _: Bool = motionManager.isAccelerometerActive
// Prints "true"
```

## Contribution

### Reporting a bug

If you find a bug, please create an issue.

### Contacting the maintainers

The current code owner of this package is Alexandre H. Saad ([@alexandrehsaad](https://github.com/alexandrehsaad)). You can contact him by writing an email to alexandresaad at icloud dot com.

## Supporting

If you like my work, show your support by staring this repository.
 
## Feedback

We would love to hear your thoughts or feedback on how Swift Motions could be improved!
