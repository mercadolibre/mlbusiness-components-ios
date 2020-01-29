//
//  DiscountTrackerData.swift
//  Example_BusinessComponents
//
//  Created by Vicente Veltri on 28/01/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class DiscountTrackerData: NSObject, MLBusinessDiscountTrackerProtocol {
    
    let basePath = "/discount_center/payers/touchpoint"
    var touchPointId: String
    
    init(touchPointId: String) {
        self.touchPointId = touchPointId
    }
    
    func track(action: String, eventData: [[String : Any]]) {
        //Melidata tracking
        print("Melidata track path: \(basePath)/\(touchPointId)/\(action) with event data: \(eventData)")
    }
}
