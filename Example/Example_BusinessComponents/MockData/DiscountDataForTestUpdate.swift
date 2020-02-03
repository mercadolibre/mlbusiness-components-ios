//
//  DiscountDataForTestUpdate.swift
//  Example_BusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/14/19.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class DiscountDataForTestUpdate: NSObject, MLBusinessDiscountBoxData {
    func getTitle() -> String? {
        return nil
    }

    func getSubtitle() -> String? {
        return nil
    }

    func getItems() -> [MLBusinessSingleItemProtocol] {
        var array: [MLBusinessSingleItemProtocol] = [MLBusinessSingleItemProtocol]()
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 100", iconImageUrl: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 500", iconImageUrl: "https://www.stickpng.com/assets/images/5a1c3211f65d84088faf13e8.png"))
        //array.append(SingleItemData(title: "Hasta", subtitle: "$ 300", iconImageUrl: "https://pbs.twimg.com/profile_images/1124417403566395394/9Wuzg8pf.png"))
        return array
    }
    
    func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol? {
        return DiscountTrackerData(touchPointId: "BusinessComponents-Example")
    }
    
}
