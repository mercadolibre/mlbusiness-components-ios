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
    var touchPointId: TouchPointId
    
    enum TouchPointId: String {
        case PX = "PX"
        case MPHome = "MPHome"
        case CheckOutOn = "ChekOutOn"
        case MeliHome = "MeliHome"
    }
    
    init(touchPointId: TouchPointId) {
        self.touchPointId = touchPointId
    }
    
    func track(action: String, eventData: [[String:Any]]) {
        //Melidata tracking
    }
}
