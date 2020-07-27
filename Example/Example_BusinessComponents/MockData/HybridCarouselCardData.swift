//
//  HybridCarouselCardData.swift
//  Example_BusinessComponents
//
//  Created by Vicente Veltri on 27/07/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class HybridCarouselCardData: NSObject, MLBusinessHybridCarouselCardData {
    func getTopImage() -> String? {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }
    
    func getTopImageAccessory() -> String? {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }
    
    func getMiddleTitle() -> String {
        return "Starbucks"
    }
    
    func getMiddleSubtitle() -> String? {
        return "Cafetería"
    }
    
    func getBottomTopLabel() -> String? {
        return nil
    }
    
    func getBottomPrimaryLabel() -> String? {
        return "15%"
    }
    
    func getBottomSecondaryLabel() -> String? {
        return "OFF"
    }
    
    func getBottomMiddleLabel() -> String? {
        return "Tope de $100"
    }
    
    func getBottomLabelStatus() -> String? {
        return "BLOCKED"
    }
    
    func getBottomInfo() -> MLBusinessHybridCarouselCardBottomInfoData? {
        return HybridCarouselCardBottomInfoData()
    }
    
    func getLink() -> String? {
        return "meli://home"
    }
    
}

class HybridCarouselCardBottomInfoData: NSObject, MLBusinessHybridCarouselCardBottomInfoData {
    func getIcon() -> String? {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }
    
    func getLabel() -> String? {
        return "QUEDA 1 DÍA"
    }
    
    func getFormat() -> MLBusinessHybridCarouselCardBottomInfoFormatData? {
        return HybridCarouselCardBottomInfoFormatData()
    }
}

class HybridCarouselCardBottomInfoFormatData: NSObject, MLBusinessHybridCarouselCardBottomInfoFormatData {
    func getTextColor() -> String {
        return "#FF7733"
    }
    
    func getBackgroundColor() -> String {
        return "#FFFFFF"
    }
}
