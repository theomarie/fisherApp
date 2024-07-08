
# FisherApp
[![forthebadge](https://forthebadge.com/images/badges/made-with-swift.svg)](https://forthebadge.com)

FisherApp is an iOS application designed for both iPhone and iPad. Built using Swift and SwiftUI, this app helps you determine if a fish is legal to catch based on an image captured with your device's camera. By leveraging a machine learning model trained with Create ML and utilizing CoreML, FisherApp provides real-time identification and information about various fish species.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What you need to install the software:

- Xcode
- Swift
- iOS Device or Simulator running iOS 13.0 or later

### Installation

Steps to install and set up the app:

1. Clone the repository:
    ```bash
    git clone https://github.com/theomarie/FisherApp.git
    ```
2. Open the project in Xcode:
    ```bash
    cd FisherApp
    open FisherApp.xcodeproj
    ```
3. Install dependencies (if any):
    ```bash
    // Insert dependency installation steps here if applicable
    ```
4. Build and run the project on your iOS device or simulator.

You should see the FisherApp running on your device, ready to identify fish!

## Running the App

To run the FisherApp:

1. Launch the FisherApp on your iPhone or iPad.
2. Use the camera function to take a picture of the fish you want to identify.
3. The app will process the image using the integrated machine learning model and provide information about whether the fish can be legally caught.
4. Identified fish data is stored locally using SwiftData, allowing you to access your identification history even when offline.

## Built With

Here are the key frameworks and tools used to develop this project:

* [Swift](https://developer.apple.com/swift/) - The programming language used
* [SwiftUI](https://developer.apple.com/xcode/swiftui/) - The user interface framework
* [CoreML](https://developer.apple.com/machine-learning/core-ml/) - Machine learning framework
* [Create ML](https://developer.apple.com/machine-learning/create-ml/) - Tool used to train the machine learning model
* [SwiftData](https://developer.apple.com/documentation/coredata) - Local storage solution


## Authors

* **Theo Marie** _alias_ [@theomarie](https://github.com/theomarie)

See also the list of [contributors](https://github.com/theomarie/FisherApp/contributors) who participated in this project.

