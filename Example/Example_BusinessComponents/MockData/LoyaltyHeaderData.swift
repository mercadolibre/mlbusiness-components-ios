//
//  LoyaltyHeaderData.swift
//  Example_BusinessComponents
//
//  Created by Nicolas Battelli on 16/09/2019.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

final class LoyaltyHeaderData: NSObject, MLBusinessLoyaltyHeaderData {
    func getBackgroundHexaColor() -> String {
        return "1AC2B0"
    }
    
    func getPrimaryHexaColor() -> String {
        return "FFFFFF"
    }
    
    func getSecondaryHexaColor() -> String {
        return "65A69E"
    }
    
    func getRingNumber() -> Int {
        return 4
    }
    
    func getRingPercentage() -> Float {
        return 0.8
    }
    
    func getTitle() -> String {
        return "Beneficios"
    }
    
    func getSubtitle() -> String {
        return "Nivel 4 - Mercado Puntos"
    }
    
    func getIconSize() -> Int {
        return 50
    }
    
    func getDescriptionSize() -> Int {
        return 14
    }
}
