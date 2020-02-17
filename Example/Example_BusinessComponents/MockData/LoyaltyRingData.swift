//
//  LoyaltyRingData.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 02/09/2019.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLBusinessComponents

class LoyaltyRingData: NSObject, MLBusinessLoyaltyRingData {
    
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
        return "Sumaste 20 Mercado Puntos"
    }

    func getButtonTitle() -> String {
        return "Ver mis beneficios"
    }

    func getButtonDeepLink() -> String {
        return "mercadopago://home"
    }
}
