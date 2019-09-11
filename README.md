![Screenshot iOS](https://github.com/juansanzone/MLBusinessComponents/blob/refactor/Documentation/images/ios_cover.png?raw=true)
<p align="center">
<a href="https://app.bitrise.io/">
<img src="https://app.bitrise.io/app/d2d19a45654ed1d8/status.svg?token=9BWGNvo1MwPKFb2wQB2dCg">
</a>
<img src="https://img.shields.io/badge/Swift-4.2-orange.svg" />
<a href="https://cocoapods.org/pods/MLBusinessComponents">
<img src="https://img.shields.io/cocoapods/v/MercadoPagoSDK.svg" alt="CocoaPods" />
</a>
<a href="https://cocoapods.org/pods/MLBusinessComponents">
<img src="https://img.shields.io/cocoapods/dt/MLBusinessComponents.svg?style=flat" alt="CocoaPods downloads" />
</a>
</p>

# 📲 How to Install

#### Using [CocoaPods](https://cocoapods.org)

Edit your `Podfile` and specify the dependency:

```ruby
pod 'MLBusinessComponents'
```

# 🐒 How to use

### 1 - Import into project.
```swift
import MLBusinessComponents
```

### 2 - Use your UI component.
Choose and instantiate your component.


# 📦 COMPONENTS
Each component is a subclass of UIView.

## 1️⃣ - MLBusinessLoyaltyRingView Component
This component allow you to show the progress ring of points, a label and actionable button. The most common use of this component is to show a user's progress within the loyalty program.
#### Visual Example:
![MLBusinessLoyaltyRingView](https://github.com/juansanzone/MLBusinessComponents/blob/refactor/Documentation/images/loyaltyRingViewComponent.png?raw=true)

### MLBusinessLoyaltyRingView init
You need to set `MLBusinessLoyaltyRingData` protocol (interfase). This protocol allow you to populate the draw data into component. (Ring progress percent, ring color, label text, button title and button deeplink).
```swift
let ringView = MLBusinessLoyaltyRingView(_ ringViewData: MLBusinessLoyaltyRingData)
view.addSubView(ringView)

/* 
    Set your constraints. You don't need to set up the HEIGHT contraint. 
    Because this component is responsible for knowing and setting your own HEIGHT.
*/
NSLayoutConstraint.activate([
    ringView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    ringView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ringView.topAnchor.constraint(equalTo: view.topAnchor)
])
```

### MLBusinessLoyaltyRingData Protocol
This protocol allow you to providade the proper data to draw `MLBusinessLoyaltyRingView`. You can setup ring progress percent, ring color, label text, button title and button deeplink). Each value is mandatory.

#### Definition
```swift
@objc public protocol MLBusinessLoyaltyRingData: NSObjectProtocol {
    @objc func getRingHexaColor() -> String
    @objc func getRingNumber() -> Int
    @objc func getRingPercentage() -> Float
    @objc func getTitle() -> String
    @objc func getButtonTitle() -> String
    @objc func getButtonDeepLink() -> String
}
```

#### Implementation Example
Implementation of `MLBusinessLoyaltyRingData` example:
```swift
class MyDrawDataForRingView: NSObject, MLBusinessLoyaltyRingData {
    func getRingNumber() -> Int {
        return 3
    }

    func getRingHexaColor() -> String {
        return "#17aad6"
    }

    func getRingPercentage() -> Float {
        return 0.80
    }

    func getTitle() -> String {
        return "Ganaste 100 Mercado Puntos"
    }

    func getButtonTitle() -> String {
        return "Mis beneficios"
    }

    func getButtonDeepLink() -> String {
        return "mercadopago://beneficios"
    }
}
```

### How to receive tap action and button deeplink?
You can be informed when the user presses the button of the component and receive the deeplink previously sent in `MLBusinessLoyaltyRingData`. Just add tapAction callback.
```swift
let ringView = MLBusinessLoyaltyRingView(MyDrawDataForRingView())
view.addSubView(ringView)

// Add tap action and receive the deepLink
ringView.addTapAction { deepLink in
    print(deepLink)
}
```

## 2️⃣ - MLBusinessDiscountBoxView Component
This component allow you to show a group of N items in a grid system (3 cols by default). You can add a title and subtitle for the main component. Also, you can provide imageUrl, title and subtitle for each item. This component is responsible for knowing and setting your own height based on number of cols and item quantity.
#### Visual Example:
![MLBusinessDiscountBoxView](https://github.com/juansanzone/MLBusinessComponents/blob/refactor/Documentation/images/discountBoxViewComponent.png?raw=true)


## 🔠 Font and color customization.
We use `MLUI` open source library to customize accent colors and font labels. In order to change those values check the documentation of `MLUI` stylesheet protocol.
https://github.com/mercadolibre/fury_mobile-ios-ui

## 😉 Next steps?
* [ ] Bitrise for releases.
* [ ] Codebeat integration.
* [ ] Snapshot Test cases.
* [ ] SwiftLint.
* [ ] Migration to Swift 5.
* [ ] iOS13 Dark Mode variant.
* [ ] Swift package manager support.
* [ ] SwiftUI bridges / UIKit <-> SwiftUI.

## 📋 Supported OS & SDK Versions
* iOS 10.0+
* Swift 4.2
* xCode 9.2+
* @Objc full compatibility

## 🔮 Project Example
This project include a Swift example project using `MLBusinessComponents` basic components.

## ❤️ Feedback
- Feel free to contribute or send feedback. Fork this project and propose your own fixes, suggestions and open a pull request with the changes.

## 👨🏻‍💻 Author
- Juan Sanzone / juan.sanzone@mercadolibre.com
- Esteban Boffa / esteban.boffa@mercadolibre.com

## 👮🏻 License

```
MIT License

Copyright (c) 2019 - Mercado Pago / Mercado Libre

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
