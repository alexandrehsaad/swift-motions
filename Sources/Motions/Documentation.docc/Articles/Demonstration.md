# Demonstration

A demonstrating on how to use this package.

## Overview

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## Using this package

The Swift Package Manager is a tool for managing the distribution of Swift code and is integrated into the swift compiler.

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
