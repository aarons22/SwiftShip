# SwiftShip

[![CI Status](http://img.shields.io/travis/Aaron Sapp/SwiftShip.svg?style=flat)](https://travis-ci.org/Aaron Sapp/SwiftShip)
[![Version](https://img.shields.io/cocoapods/v/SwiftShip.svg?style=flat)](http://cocoapods.org/pods/SwiftShip)
[![License](https://img.shields.io/cocoapods/l/SwiftShip.svg?style=flat)](http://cocoapods.org/pods/SwiftShip)
[![Platform](https://img.shields.io/cocoapods/p/SwiftShip.svg?style=flat)](http://cocoapods.org/pods/SwiftShip)

A toolbelt for interacting with shipping APIs. Currently only supporting US based shipping.
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Dependencies
We use the following libraries as dependencies inside of SwiftShip:

- [Alamofire](https://github.com/Alamofire/Alamofire), for HTTP requests

## Requirements

- iOS 9.0+
- Xcode 8.0+
- Swift 3.0+
- [Register](https://registration.shippingapis.com/) for a USPS Web Tools user account.

## Installation

SwiftShip is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftShip"
```

## Usage

### Getting a shipping rate

```Swift
let shipService = SwiftShip(userIdUSPS: "[USPS_USER_ID]")
shipService.getUSPSRate(fromZip: 12345, toZip: 67890, pounds: 12, ounces: 0.3, container: .mdFlatRateBox, size: .regular) { rate, error in
            if error != "" {
                print("Error: \(error)")
            } else {
                print("Rate: \(rate)")
            }
        }
```

### USPSServiceTypes
- priority = "Priority"
- priorityCommercial = "Priority Commercial"
- priorityCpp = "Priority Cpp"
- priorityHFPCommercial = "Priority HFP Commercial"
- priorityHFPCPP = "Priority HFP CPP"
- priorityMailExpress = "Priority Mail Express"
- priorityMailExpressCommercial = "Priority Mail Express Commercial"
- priorityMailExpressCPP = "Priority Mail Express CPP"
- priorityMailExpressSh = "Priority Mail Express Sh"
- priorityMailExpressShCommercial = "Priority Mail Express Sh Commercial"
- priorityMailExpressHFP = "Priority Mail Express HFP"
- priorityMailExpressHFPCommercial = "Priority Mail Express HFP Commercial"
- priorityMailExpressHFPCPP = "Priority Mail Express HFP CPP"
- retailGround = "Retail Ground"
- media = "Media"
- library = "Library"
- all = "All"
- online = "Online"
- plus = "Plus"

### USPSContainerTypes
- variable = "VARIABLE"
- flatRateEnvelope = "FLAT RATE ENVELOPE"
- paddedFlatRateEnvelope = "PADDED FLAT RATE ENVELOPE"
- legalFlatRateEnvelope = "LEGAL FLAT RATE ENVELOPE"
- smFlatRateEnvelope = "SM FLAT RATE ENVELOPE"
- windowFlatRateEnvelope = "WINDOW FLAT RATE ENVELOPE"
- iftCardFlatRateEnvelope = "IFT CARD FLAT RATE ENVELOPE"
- smFlatRateBox = "SM FLAT RATE BOX"
- mdFlatRateBox = "MD FLAT RATE BOX"
- lgFlatRateBox = "LG FLAT RATE BOX"
- regionalRateBoxA = "REGIONALRATEBOXA"
- regionalRateBoxB = "REGIONALRATEBOXB"
- rectangular = "RECTANGULAR"
- nonRectangular = "NONRECTANGULAR"

### USPSSizes
- regular (Package dimensions are 12" or less)
- large (Any package dimension is larger than 12")

## TODO

- UPS
- FedEx

## Author

Aaron Sapp ([@aaronsapp](https://twitter.com/aaronsapp))

## License

SwiftShip is available under the MIT license. See the LICENSE file for more info.
