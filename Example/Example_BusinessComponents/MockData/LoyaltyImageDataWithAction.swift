//
//  LoyaltyImageDataWithAction.swift
//  Example_BusinessComponents
//
//  Created by Guido Maceira on 12/06/2023.
//  Copyright © 2023 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

class LoyaltyImageDataWithAction: NSObject, MLBusinessLoyaltyRingData {
    
    func getTitle() -> String {
        return "Sumaste 400 puntos. <b>¡Ya sos Nivel6!</b>"
    }
    
    func getSubtitle() -> String? {
        return nil
    }
    
    func getButtonTitle() -> String {
        return "Consultar mis beneficios"
    }
    
    func getButtonDeepLink() -> String {
        return "mercadopago://home"
    }
    
    func getImageUrl() -> String? {
        return "https://i.ibb.co/8d2yZtZ/logo.png"
    }
}

