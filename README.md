![Screenshot iOS](https://github.com/mercadolibre/mlbusiness-components-ios/blob/master/Documentation/images/ios_cover.png?raw=true)
<p align="center">
<a href="https://app.bitrise.io/app/3bb8e8193945cb87">
<img src="https://app.bitrise.io/app/3bb8e8193945cb87/status.svg?token=nOcqLjeT7sqGObFhel48ag">
</a>
    
<a href="https://codebeat.co/projects/github-com-mercadolibre-mlbusiness-components-ios-master">
<img src="https://codebeat.co/badges/5cc16dc0-cfdf-435a-a6c5-9d86566a7e95" alt="Codebeat quality status" />
</a>
    
<img src="https://img.shields.io/badge/Swift-4.2-orange.svg" />
<a href="https://cocoapods.org/pods/MLBusinessComponents">
<img src="https://img.shields.io/cocoapods/v/MLBusinessComponents.svg" alt="CocoaPods" />
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
![MLBusinessLoyaltyRingView](https://github.com/mercadolibre/mlbusiness-components-ios/blob/master/Documentation/images/loyaltyRingViewComponent.png?raw=true)

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
![MLBusinessDiscountBoxView](https://github.com/mercadolibre/mlbusiness-components-ios/blob/master/Documentation/images/discountBoxViewComponent.png?raw=true)

### MLBusinessDiscountBoxView init
You need to set `MLBusinessDiscountBoxData` protocol. This interface allow you to populate the draw data into component. (Title, subtitle for the main component and imageUrl. Title, subtitle, deepLinkItem and trackId for each item).

```swift
// DiscountData() is an implementation of MLBusinessDiscountBoxData protocol.
let discountView = MLBusinessDiscountBoxView(DiscountData())
view.addSubview(discountView)

/* 
    Set your constraints. You don't need to set up the HEIGHT contraint. 
    Because this component is responsible for knowing and setting your own HEIGHT.
*/
NSLayoutConstraint.activate([
   discountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
   discountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
   discountView.topAnchor.constraint(equalTo: targetView.bottomAnchor)
])
```

### MLBusinessDiscountBoxData Protocol
This protocol allow you to providade the proper data to draw `MLBusinessDiscountBoxView`. You can setup title and subtitle for the main component and a list of `MLBusinessDiscountSingleItemProtocol` that represent each element of the cell.

#### Definition
```swift
@objc public protocol MLBusinessDiscountBoxData: NSObjectProtocol {
    @objc optional func getTitle() -> String?
    @objc optional func getSubtitle() -> String?
    @objc func getItems() -> [MLBusinessSingleItemProtocol]
}
```

Implementation of `MLBusinessDiscountBoxData` in DiscountData example:
```swift
class DiscountData: NSObject, MLBusinessDiscountBoxData {
    func getTitle() -> String {
        return "200 descuentos"
    }

    func getSubtitle() -> String {
        return "por ser nivel 3"
    }

    func getItems() -> [MLBusinessSingleItemProtocol] {
        var array: [MLBusinessSingleItemProtocol] = [MLBusinessSingleItemProtocol]()
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1200px-McDonald%27s_Golden_Arches.svg.png"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY0eFECzyTCa83gOV3smCYDOSIggdUxSPirwtt5rS3LcWlzefo"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b3/Logo-freddo.jpg"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://www.stickpng.com/assets/images/5a1c3211f65d84088faf13e8.png"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://pbs.twimg.com/profile_images/1124417403566395394/9Wuzg8pf.png"))
        return array
    }
}
```
### SingleItem Protocol
This protocol/interfase represents the element of each cell for `MLBusinessDiscountBoxView`.
Each element contains imageUrl, title, subtitle, deepLinkItem and trackId.

#### Definition
```swift
@objc public protocol MLBusinessSingleItemProtocol: NSObjectProtocol {
    @objc func titleForItem() -> String
    @objc func subtitleForItem() -> String
    @objc func iconImageUrlForItem() -> String
    @objc func deepLinkForItem() -> String?
    @objc func trackIdForItem() -> String?
}
```

Implementation of `MLBusinessSingleItemProtocol` in example:
```swift
class SingleItemData: NSObject {
    let title: String
    let subTitle: String
    let iconUrl: String
    let deepLink: String?
    let trackId: String?

    init(title: String, subtitle: String, iconImageUrl: String, deepLink: String? = nil, trackId: String? = nil) {
        self.title = title
        self.subTitle = subtitle
        self.iconUrl = iconImageUrl
        self.deepLink = deepLink
        self.trackId = trackId
    }
}

extension SingleItemData: MLBusinessSingleItemProtocol {
    func titleForItem() -> String {
        return title
    }

    func subtitleForItem() -> String {
        return subTitle
    }

    func iconImageUrlForItem() -> String {
        return iconUrl
    }

    func deepLinkForItem() -> String? {
        return deepLink
    }

    func trackIdForItem() -> String? {
        return trackId
    }
}
```

### How to receive a tap action of item with the deep link and trackId?
You can be informed when the user presses the item of the component and receive the deeplink, trackId and item index previously sent in `MLBusinessSingleItemProtocol`
```swift
discountView.addTapAction { (selectedIndex, deepLink, trackId) in
   print(selectedIndex)
}
```

### How to update component data ?
In order to keep the same reference and update only the data and layout you can call to update method. `MLBusinessDiscountBoxView`
```swift
discountView.update(_ MLBusinessDiscountBoxData)
```

## 3️⃣ - MLBusinessDividingLineView Component
This component allows you to draw a dividing line in order to separate views. For example, it can be used to separate the MLBusinessLoyaltyRingView component from the MLBusinessDownloadAppView component.
#### Visual Example:
![MLBusinessDividingLineView](https://github.com/mercadolibre/mlbusiness-components-ios/blob/master/Documentation/images/dividingLineViewComponent.png)

### MLBusinessDividingLineView init
The init method receives an optional parameter named: 'hasTriangle'. This parameter is 'false' by default. When this parameter is sent as 'true', a rect line with a downward triangle in the center is drawn. Conversely, just a single rect line is shown.

```swift
let dividingLineView = MLBusinessDividingLineView(hasTriangle: true)
view.addSubview(dividingLineView)

/* 
    Set your constraints. You don't have to set up the HEIGHT contraint. 
*/
NSLayoutConstraint.activate([
    dividingLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    dividingLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    dividingLineView.topAnchor.constraint(equalTo: view.topAnchor)
])
```

## 4️⃣ - MLBusinessDownloadAppView Component
This component allows you to show a view with an image of the app icon (ML or MP), a title and an actionable button in order to download the app.
#### Visual Example:
![MLBusinessDownloadAppView](https://github.com/mercadolibre/mlbusiness-components-ios/blob/master/Documentation/images/downloadAppViewComponent.png)

### MLBusinessDownloadAppView init
You need to set `MLBusinessDownloadAppData` protocol. This interface allows you to populate the draw data into the component (appSite, title, buttonTitle and buttonDeepLink, being all of them mandatory).

```swift
// DownloadAppData() is an implementation of MLBusinessDownloadAppData protocol.
let downloadAppView = MLBusinessDownloadAppView(DownloadAppData())
view.addSubview(downloadAppView)

/* 
    Set your constraints. You don't need to set up the HEIGHT contraint. 
    Because this component is responsible for knowing and setting its own HEIGHT.
*/
NSLayoutConstraint.activate([
    downloadAppView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    downloadAppView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    downloadAppView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
])
```

### MLBusinessDownloadAppData Protocol
This protocol allows you to provide the proper data to draw `MLBusinessDownloadAppView`. You have to setup the following data: appSite(ML or MP), title, buttonTitle, and buttonDeepLink.

#### Definition
```swift
@objc public protocol MLBusinessDownloadAppData: NSObjectProtocol {
    @objc func getAppSite() -> MLBusinessDownloadAppView.AppSite
    @objc func getTitle() -> String
    @objc func getButtonTitle() -> String
    @objc func getButtonDeepLink() -> String
}
```
Implementation of `MLBusinessDownloadAppData` in DownloadAppData example:
```swift
class DownloadAppData: NSObject, MLBusinessDownloadAppData {

    func getAppSite() -> MLBusinessDownloadAppView.AppSite {
        return MLBusinessDownloadAppView.AppSite.MP
    }
    func getTitle() -> String {
        return "Exclusivo con la app de Mercado Pago"
    }
    func getButtonTitle() -> String {
        return "Descargar"
    }
    func getButtonDeepLink() -> String {
        return "http://mercadopago"
    }
}
```
### How to receive a tap action of item with the deep link?
You can be informed when the user presses the download button and receive the deeplink previously sent in `MLBusinessDownloadAppData`
```swift
downloadAppView.addTapAction { (deepLink) in
   print(deepLink)
}
```

### How to change DownloadAppView background? 
Using `setBackgroundColor` method.
```swift
downloadAppView.setBackgroundColor(.red)
```

### How to change DownloadAppView default corner radius? 
Using `setCornerRadius` method.
```swift
downloadAppView.setCornerRadius(0)
```

## 5️⃣ - MLBusinessCrossSellingBoxView Component
This component allows you to show a view with an image icon, a text and an actionable button.
#### Visual Example:
![MLBusinessCrossSellingBoxView](https://github.com/mercadolibre/mlbusiness-components-ios/blob/master/Documentation/images/crossSellingBoxViewComponent.png)

### MLBusinessCrossSellingBoxView init
You need to set `MLBusinessCrossSellingBoxData` protocol. This interface allows you to populate the draw data into the component (iconUrl, text, buttonTitle and buttonDeepLink, being all of them mandatory).

```swift
// CrossSellingBoxData() is an implementation of MLBusinessCrossSellingBoxData protocol.
let crossSellingBoxView = MLBusinessCrossSellingBoxView(CrossSellingBoxData())
view.addSubview(crossSellingBoxView)

/* 
    Set your constraints. You don't need to set up the HEIGHT contraint. 
    Because this component is responsible for knowing and setting its own HEIGHT.
*/
NSLayoutConstraint.activate([
    crossSellingBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    crossSellingBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    crossSellingBoxView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
])
```
### MLBusinessCrossSellingBoxData Protocol
This protocol allows you to provide the proper data to draw `MLBusinessCrossSellingBoxView`. You have to setup the following data: iconUrl, text, buttonTitle and buttonDeepLink.

#### Definition
```swift
@objc public protocol MLBusinessCrossSellingBoxData: NSObjectProtocol {
    @objc func getIconUrl() -> String
    @objc func getText() -> String
    @objc func getButtonTitle() -> String
    @objc func getButtonDeepLink() -> String
}
```
Implementation of `MLBusinessCrossSellingBoxData` in CrossSellingBoxData example:
```swift
class CrossSellingBoxData: NSObject, MLBusinessCrossSellingBoxData {

    func getIconUrl() -> String {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }
    func getText() -> String {
        return "Ganá $ 50 de regalo para tus pagos diarios"
    }
    func getButtonTitle() -> String {
        return "Invita a más amigos a usar la app"
    }
    func getButtonDeepLink() -> String {
        return "https://mercadopago-crossSelling"
    }
}
```
### How to receive a tap action of item with the deep link?
You can be informed when the user presses the actionable button and receive the deeplink previously sent in `MLBusinessCrossSellingBoxData`
```swift
crossSellingBoxView.addTapAction { (deepLink) in
    print(deepLink)
}
```

## 6️⃣ - MLBusinessLoyaltyHeaderView Component
This component allow you to show the progress ring of points, title and subtitle.
#### Visual Example:
![loyaltyHeader](https://user-images.githubusercontent.com/1513008/65156105-da609d80-da04-11e9-9b8e-e896661e4d24.png)

```swift
// LoyaltyHeaderData() is an implementation of MLBusinessLoyaltyHeaderData protocol.
let loyaltyHeaderView = MLBusinessLoyaltyHeaderView(LoyaltyHeaderData(), fillPercentProgress: true)
containerView.addSubview(loyaltyHeaderView)

/* 
Set your constraints. You don't need to set up the HEIGHT contraint. 
Because this component is responsible for knowing and setting its own HEIGHT.
*/
NSLayoutConstraint.activate([
loyaltyHeaderView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
loyaltyHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
loyaltyHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
])
return loyaltyHeaderView
])
```
### MLBusinessLoyaltyHeaderData Protocol
This protocol allows you to provide the proper data to draw `MLBusinessLoyaltyHeaderView`. You have to setup the following data:

#### Definition
```swift
@objc public protocol MLBusinessLoyaltyHeaderData: NSObjectProtocol {
@objc func getBackgroundHexaColor() -> String
@objc func getPrimaryHexaColor() -> String
@objc func getSecondaryHexaColor() -> String
@objc func getRingNumber() -> Int
@objc func getRingPercentage() -> Float
@objc func getTitle() -> String
@objc func getSubtitle() -> String
}
```

Implementation of `MLBusinessLoyaltyHeaderData` in LoyaltyHeaderData example:
```swift
import MLBusinessComponents

class LoyaltyHeaderData: NSObject, MLBusinessLoyaltyHeaderData {
func getBackgroundHexaColor() -> String {
return "1AC2B0"
}

func getPrimaryHexaColor() -> String {
return "FFFFFF"
}

func getSecondaryHexaColor() -> String {
return "65A69E"
}

func getRingNumber() -> Int {
return 4
}

func getRingPercentage() -> Float {
return 0.8
}

func getTitle() -> String {
return "Beneficios"
}

func getSubtitle() -> String {
return "Nivel 4 - Mercado Puntos"
}
}
```

## 7️⃣ - MLBusinessItemDescriptionView Component
This component allow you to show the an icon and a title.
#### Visual Example:
![iconDescription](https://user-images.githubusercontent.com/1513008/65180512-6be70400-da33-11e9-8380-d915ad47902a.png)

```swift
// ItemDescriptionData() is an implementation of MLBusinessItemDescriptionData protocol.
let itemDescriptionView = MLBusinessItemDescriptionView(ItemDescriptionData())
containerView.addSubview(itemDescriptionView)

/* 
Set your constraints. You don't need to set up the HEIGHT contraint. 
Because this component is responsible for knowing and setting its own HEIGHT.
*/
NSLayoutConstraint.activate([
            itemDescriptionView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            itemDescriptionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            itemDescriptionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])
```
### MLBusinessItemDescriptionData Protocol
This protocol allows you to provide the proper data to draw `MLBusinessItemDescriptionView`. You have to setup the following data:

#### Definition
```swift
@objc func getTitle() -> String
@objc func getIconImageURL() -> String
@objc func getIconHexaColor() -> String
```

Implementation of `MLBusinessItemDescriptionData` in ItemDescriptionData example:
```swift
import MLBusinessComponents

final class ItemDescriptionData: NSObject, MLBusinessItemDescriptionData {

    func getTitle() -> String {
        return "Envíos gratis desde $ 1.999"
    }

    func getIconImageURL() -> String {
        return "https://http2.mlstatic.com/static/org-img/loyalty/benefits/mobile/ic-shipping-discount-64.png"
    }

    func getIconHexaColor() -> String {
        return "1AC2B0"
    }
}

```

## 8️⃣ - MLBusinessAnimatedButton Component
This component allow you to show a animated button. When you press it, it becomes a circle and then expands across the whole screen.
#### Visual Example:
![AnimatedButton](https://user-images.githubusercontent.com/45973176/68676280-7526b580-0538-11ea-83d9-7f91f4825644.gif)

```swift
/* 
To implement this component we only need to initialize it with a String for its normal state 
and another for its load state.
*/

let animatedButton = MLBusinessAnimatedButton(normalLabel: "Normal", loadingLabel: "Loading")
containerView.addSubview(animatedButton)

/* 
Set your constraints. You don't need to set up the HEIGHT contraint. 
Because this component is responsible for knowing and setting its own HEIGHT.
*/

NSLayoutConstraint.activate([
animatedButton.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
animatedButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
animatedButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
])

// To start the animation we must call the method called startLoading().
animatedButton.startLoading()

/* 
To end the animation we must call the method called finishLoading(color: UIColor, image: UIImage)
Where we can set the color with which it will expand
and an optional image that will be displayed on the button when it becomes circular.
*/
animatedButton.finishLoading(color: .green, image: nil)

/*
Additionally, the component provides us with a function to push the next view controller with a Fade effect.
*/
animatedButton.goToNextViewController(newViewController, navigationController)
```
### MLBusinessAnimatedButtonDelegate
This protocol allows you to execute actions once the animation is over and also in the case of a possible time out.

#### Definition
```swift
@objc func didFinishAnimation(_ animatedButton: MLBusinessAnimatedButton)
@objc func progressButtonAnimationTimeOut()
@objc optional func expandAnimationInProgress()
```

Implementation of `MLBusinessAnimatedButtonDelegate` :
```swift
import MLBusinessComponents

extension ViewController: MLBusinessAnimatedButtonDelegate {
    func didFinishAnimation(_ animatedButton: MLBusinessAnimatedButton) {
        guard let navigationController = navigationController else { return }

        let newVC = UIViewController()
        newVC.view.backgroundColor = .red

        animatedButton.goToNextViewController(newVC, navigationController)
    }

    func progressButtonAnimationTimeOut() {
        print("TimeOut")
    }

    func expandAnimationInProgress() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

```

## 🔠 Font and color customization.
We use `MLUI` open source library to customize accent colors and font labels. In order to change those values check the documentation of `MLUI` stylesheet protocol.
https://github.com/mercadolibre/fury_mobile-ios-ui

## 😉 Next steps?
* [X] Bitrise for releases.
* [X] Codebeat integration.
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
