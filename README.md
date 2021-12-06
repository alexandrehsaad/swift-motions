# motion-kit

## Installation

To use this package in a SwiftPM project:

1. Add it to the dependencies in your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/alexandrehsaad/motion-kit.git", branch: "main")
    ],
    ...
)
```

2. Add it as a dependency for your target in your `Package.swift` file:

```swift
let package = Package(
    ...
    targets: [
        .target(name: "MyTarget", dependencies: [
            .product(name: "MotionKit", package: "motion-kit")
        ]),
    ],
    ...
)
```

3. Import the package in your source code.

```swift
import MotionKit
```

## Contribution

### Reporting a bug

If you find a bug, please open a bug report.

### Contacting the maintainers

The current code owner of this package is Alexandre H. Saad ([@alexandrehsaad](https://github.com/alexandrehsaad)). You can contact him by writing an email to alexandresaad at icloud dot com.

## Supporting

If you like our work, show your support by staring this repository.

## Feedback

We would love to hear your thoughts or feedback on how we can improve Motion Kit!
