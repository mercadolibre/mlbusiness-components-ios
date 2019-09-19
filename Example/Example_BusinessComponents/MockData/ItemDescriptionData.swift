//
//  ItemDescriptionData.swift
//  Example_BusinessComponents
//
//  Created by Nicolas Battelli on 18/09/2019.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

final class ItemDescriptionData: NSObject, MLBusinessItemDescriptionData {
    
    func getTitle() -> String {
        return "Envíos gratis desde $ 1.999"
    }
    @objc func getIconImageURL() -> String {
        return "https://http2.mlstatic.com/static/org-img/loyalty/benefits/mobile/ic-shipping-discount-64.png"
    }
    func getIconHexaColor() -> String {
        return "1AC2B0"
    }
}
