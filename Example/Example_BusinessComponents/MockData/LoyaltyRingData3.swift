//
//  LoyaltyRingData2.swift
//  Example_BusinessComponents
//
//  Created by Dario Facundo Gaspar on 03/05/2023.
//  Copyright © 2023 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

class LoyaltyRingData3: NSObject, MLBusinessLoyaltyRingData {
    
    func getTitle() -> String {
        return "<b>Sumaste 20 Mercado </b>Puntos"
    }
    
    func getButtonTitle() -> String {
        return "Ver mis beneficios"
    }
    
    func getSubtitle() -> String {
        return "Una vez que se acredite tu pago, ganarás 20 puntos."
    }
    
    func getButtonDeepLink() -> String {
        return "mercadopago://home"
    }
    
    func getImageUrl() -> String{
        return "https://i.ibb.co/8d2yZtZ/logo.png"
    }
}

