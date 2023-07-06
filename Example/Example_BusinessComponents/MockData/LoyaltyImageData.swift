//
//  LoyaltyImageData.swift
//  Example_BusinessComponents
//
//  Created by Dario Facundo Gaspar on 03/05/2023.
//  Copyright © 2023 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

class LoyaltyImageData: NSObject, MLBusinessLoyaltyRingData {
    
    func getTitle() -> String {
        return "<b>Sumaste 400 puntos.</b> Estás más cerca de ser Nivel6"
    }
    
    func getSubtitle() -> String? {
        return nil
    }
    
    func getButtonTitle() -> String? {
        return nil
    }
    
    func getButtonDeepLink() -> String? {
        return nil
    }
    
    func getImageUrl() -> String{
        return "https://i.ibb.co/8d2yZtZ/logo.png"
    }
}

