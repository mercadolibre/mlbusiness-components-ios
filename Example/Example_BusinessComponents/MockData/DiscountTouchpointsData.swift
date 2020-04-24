//
//  DiscountTouchpointsData.swift
//  Example_BusinessComponents
//
//  Created by Vicente Veltri on 23/04/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import MLBusinessComponents

class DiscountTouchpointsData: NSObject, MLBusinessTouchpointsData {

    private let type: String
    private let numberOfItems: Int
    
    init(type: String = "GRID", numberOfItems: Int = 5) {
        self.type = type
        self.numberOfItems = 5 - (min(numberOfItems, 6) - 1)
    }
    
    func getType() -> String {
        return type
    }
    
    func getContent() -> [String : Any] {
        switch type {
        case "GRID":
            var items: [[String : Any]] = []
            items.append(createItem(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1200px-McDonald%27s_Golden_Arches.svg.png", deepLink: "meli://home", eventData: ["trackingId":"0"]))
            items.append(createItem(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY0eFECzyTCa83gOV3smCYDOSIggdUxSPirwtt5rS3LcWlzefo", deepLink: "meli://home", eventData: ["trackingId":"1"]))
            items.append(createItem(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b3/Logo-freddo.jpg", deepLink: "meli://home",  eventData: ["trackingId":"2"]))
            items.append(createItem(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png", deepLink: "meli://home", eventData: ["trackingId":"3"]))
            items.append(createItem(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://i0.wp.com/larchmontla.com/ui/wp-content/uploads/2011/01/images_le-pain-quotidien.gif", deepLink: "meli://home", eventData: ["trackingId":"4"]))
            items.append(createItem(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://pbs.twimg.com/profile_images/1124417403566395394/9Wuzg8pf.png", deepLink: "meli://home", eventData: ["trackingId":"5"]))
            let shiftedItems = Array(items.suffix(from: numberOfItems)).shift(withDistance: Int.random(in: 1...5))
            let content: [String : Any] = ["title": "Nuevos", "subtitle": "Touchpoints", "items" : shiftedItems]
            return content
        default:
            return [:]
        }
    }
    
    func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol? {
        return DiscountTrackerData(touchPointId: "BusinessComponents-Example")
    }
}

func createItem(title: String, subtitle: String, iconImageUrl: String, deepLink: String, eventData: [String : Any]) -> [String : Any] {
    return ["title" : title, "subtitle" : subtitle, "iconImageUrl" : iconImageUrl, "deepLink" : deepLink, "eventData" : eventData]
}

