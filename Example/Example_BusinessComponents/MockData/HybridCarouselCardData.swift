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
    
    private static let imageAccesoryURL = "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    private let topImageAccessory: String?
    private let middleTitle: String
    private let middleSubtitle: String?
    private let bottomTopLabel: String?
    private let bottomPrimaryLabel: String?
    private let bottomSecondaryLabel: String?
    private let bottomLabelStatus: String?
    private let bottomInfoData: HybridCarouselCardBottomInfoData?
    
    
    init(with topImageAccesory: String? = imageAccesoryURL, middleTitle: String = "Starbucks", middleSubtitle: String? = "Cafeteria", bottomTopLabel: String? = nil, bottomPrimaryLabel: String? = "15%", bottomSecondaryLabel: String? = "OFF", bottomLabelStatus: String? = "BLOCKED", bottomInfoData: HybridCarouselCardBottomInfoData? = HybridCarouselCardBottomInfoData()) {
        self.topImageAccessory = topImageAccesory
        self.middleTitle = middleTitle
        self.middleSubtitle = middleSubtitle
        self.bottomTopLabel = bottomTopLabel
        self.bottomPrimaryLabel = bottomPrimaryLabel
        self.bottomSecondaryLabel = bottomSecondaryLabel
        self.bottomLabelStatus = bottomLabelStatus
        self.bottomInfoData = bottomInfoData
    }
    
    func getTopImage() -> String? {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }
    
    func getTopImageAccessory() -> String? {
        return topImageAccessory
    }
    
    func getMiddleTitle() -> String {
        return middleTitle
    }
    
    func getMiddleSubtitle() -> String? {
        return middleSubtitle
    }
    
    func getBottomTopLabel() -> String? {
        return nil
    }
    
    func getBottomPrimaryLabel() -> String? {
        return bottomPrimaryLabel
    }
    
    func getBottomSecondaryLabel() -> String? {
        return bottomSecondaryLabel
    }
    
    func getBottomLabelStatus() -> String? {
        return bottomLabelStatus
    }
    
    func getBottomInfo() -> MLBusinessHybridCarouselCardBottomInfoData? {
        return bottomInfoData
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
