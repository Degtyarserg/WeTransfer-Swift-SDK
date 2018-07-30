# WeTransfer-Swift-SDK
A Swift SDK for WeTransfer’s public API

[![Build Status](https://travis-ci.com/WeTransfer/WeTransfer-Swift-SDK.svg?token=Ur5V2zzKmBJLmMYHKJTF&branch=master)](https://travis-ci.com/WeTransfer/WeTransfer)
![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/WeTransfer-Swift-SDK.svg)](https://cocoapods.org/pod/WeTransfer-Swift-SDK)
[![Platform](https://img.shields.io/cocoapods/p/WeTransfer-Swift-SDK.svg?style=flat)](http://cocoapods.org/pods/WeTransfer-Swift-SDK)

For your API key and additional info please visit our [developer portal](https://developers.wetransfer.com).

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Communication](#communication)
- [License](#license)

## Features

- [x] Create and upload a transfer from a single method call
- [x] Seperate methods for each seperate step in the process
- [ ] Cancelling and resuming uploads

## Requirements
- iOS 9.0+ / macOS 10.10+
- Xcode 9.4+
- Swift 4.1+

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](https://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate WeTransfer into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "WeTransfer/WeTransfer-Swift-SDK" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `WeTransfer.framework` into your Xcode project.

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

To integrate the WeTransfer Swift SDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```rubygi
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'WeTransfer-Swift-SDK', '>= 1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage
Before the SDK can do anything with the WeTransfer API, it needs to be authenticated with an API key. You can create an API key at the [developer portal](https://developers.wetransfer.com)

1. Configure the client
Create a configuration with your API key
```swift
let configuration = WeTransfer.Configuration(apiKey: "YOUR_API_KEY")`
WeTransfer.configure(with: configuration)
```
2. Uploading files with a new transfer
Creating a transfer and uploading files to it can be done with one method call, `WeTransfer.uploadTransfer`. Files in the SDK are represented by `File` objects, but this convenience methods expects an array of `URL`s pointing to files on your device.
In the `stateChanged` closure you're updated about things like the upload progress or whether is has completed or failed
```swift
let files = [...]
WeTransfer.uploadTransfer(named: "Transfer Name", containing: files) { state in
    switch state {
    case .created(let transfer):
        print("Transfer created")
    case .uploading(let progress):
        print("Transfer uploading")
    case .completed(let transfer):
        print("Upload completed")
    case .failed(let error):
        XCTFail("Transfer failed: \(error.localizedDescription)")
    }
}
```

## Communication

- If you **found a bug**, open an [issue](https://github.com/WeTransfer/WeTransfer-Swift-SDK/issues).
- If you **have a feature request**, open an [issue](https://github.com/WeTransfer/WeTransfer-Swift-SDK/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/WeTransfer/WeTransfer-Swift-SDK/pulls).

## License

The WeTransfer Swift SDK is available under the MIT license. See the [LICENSE](https://github.com/WeTransfer/WeTransfer-Swift-SDK/blob/develop/LICENSE) file for more info.