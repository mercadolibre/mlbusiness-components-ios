//
//  ExampleViewController+DiscountBoxData.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 29/08/2019.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLBusinessComponents

class DiscountData: NSObject, MLBusinessDiscountBoxData {
    
    private let numberOfItems: Int
    
    init(numberOfItems: Int = 5) {
        self.numberOfItems = 5 - (min(numberOfItems, 6) - 1)
    }
    
    func getTitle() -> String? {
        return Bool.random() ? "200 descuentos" : nil
    }

    func getSubtitle() -> String? {
        return "por ser nivel 3"
    }

    func getItems() -> [MLBusinessSingleItemProtocol] {
        var array: [MLBusinessSingleItemProtocol] = [MLBusinessSingleItemProtocol]()
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1200px-McDonald%27s_Golden_Arches.svg.png", deepLink: "meli://home"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY0eFECzyTCa83gOV3smCYDOSIggdUxSPirwtt5rS3LcWlzefo", deepLink: "meli://home"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b3/Logo-freddo.jpg", deepLink: "meli://home"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png", deepLink: "meli://home"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://i0.wp.com/larchmontla.com/ui/wp-content/uploads/2011/01/images_le-pain-quotidien.gif", deepLink: "meli://home"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://pbs.twimg.com/profile_images/1124417403566395394/9Wuzg8pf.png", deepLink: "meli://home"))
        return Array(array.suffix(from: numberOfItems)).shift(withDistance: Int.random(in: 1...5))
    }
}

private extension Array {
    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
            self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
            self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
        
        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
    
    mutating func shiftInPlace(withDistance distance: Int = 1) {
        self = shift(withDistance: distance)
    }
    
    func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol? {
        return DiscountTrackerData(touchPointId: "BusinessComponents-Example")
    }
}
