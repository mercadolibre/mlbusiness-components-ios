//
//  DiscountTouchpointsGridData.swift
//  Example_BusinessComponents
//
//  Created by Vicente Veltri on 23/04/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import MLBusinessComponents

class DiscountTouchpointsGridData: NSObject, MLBusinessTouchpointsData {

    private let numberOfItems: Int
    
    init(numberOfItems: Int = 5) {
        self.numberOfItems = 5 - (min(numberOfItems, 6) - 1)
    }
    
    func getResponse() -> MLBusinessTouchpointsDataResponse {
        
        return DiscountTouchpointsGridDataResponse(numberOfItems: numberOfItems)
    }
    
    func getTouchpointsTracker() -> MLBusinessDiscountTrackerProtocol? {
        return DiscountTrackerData(touchPointId: "BusinessComponents-Example")
    }
}

func createItem(title: String, subtitle: String, image: String, link: String, eventData: [String : Any]) -> [String : Any] {
    return ["title" : title, "subtitle" : subtitle, "image" : image, "link" : link, "eventData" : eventData]
}

private class DiscountTouchpointsGridDataResponse: NSObject, MLBusinessTouchpointsDataResponse {
    
    private let numberOfItems: Int
    
    init(numberOfItems: Int) {
        self.numberOfItems = numberOfItems
    }
    
    func getTouchpointId() -> String {
        return "BusinessComponents-Example"
    }
    
    func getTouchpointType() -> String {
        return "GRID"
    }
    
    func getTouchpointContent() -> [String : Any] {
        var items: [[String : Any]] = []
        
        items.append(createItem(title: "Hasta", subtitle: "$ 200", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1200px-McDonald%27s_Golden_Arches.svg.png", link: "meli://home", eventData: ["tracking_id":"0"]))
        items.append(createItem(title: "Hasta", subtitle: "$ 200", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY0eFECzyTCa83gOV3smCYDOSIggdUxSPirwtt5rS3LcWlzefo", link: "meli://home", eventData: ["tracking_id":"1"]))
        items.append(createItem(title: "Hasta", subtitle: "$ 200", image: "https://upload.wikimedia.org/wikipedia/commons/b/b3/Logo-freddo.jpg", link: "meli://home",  eventData: ["tracking_id":"2"]))
        items.append(createItem(title: "Hasta", subtitle: "$ 200", image: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png", link: "meli://home", eventData: ["tracking_id":"3"]))
        items.append(createItem(title: "Hasta", subtitle: "$ 200", image: "https://i0.wp.com/larchmontla.com/ui/wp-content/uploads/2011/01/images_le-pain-quotidien.gif", link: "meli://home", eventData: ["tracking_id":"4"]))
        items.append(createItem(title: "Hasta", subtitle: "$ 200", image: "https://pbs.twimg.com/profile_images/1124417403566395394/9Wuzg8pf.png", link: "meli://home", eventData: ["tracking_id":"5"]))
        
        let shiftedItems = Array(items.suffix(from: numberOfItems)).shift(withDistance: Int.random(in: 1...5))
        
        return ["title": "Nuevos", "subtitle": "Touchpoints", "items" : shiftedItems] as [String : Any]
    }
}

