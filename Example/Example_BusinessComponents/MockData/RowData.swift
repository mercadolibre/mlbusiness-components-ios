//
//  RowData.swift
//  Example_BusinessComponents
//
//  Created by Vicente Veltri on 22/07/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class RowData: NSObject, MLBusinessRowData {
    func getLeftImage() -> String? {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }
    
    func getLeftImageAccessory() -> String? {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }
    
    func getMainTitle() -> String {
        return "Starbucks"
    }
    
    func getMainSubtitle() -> String? {
        return "Cafetería"
    }
    
    func getMainDescription() -> [MLBusinessRowMainDescriptionData]? {
        return [RowMainDescriptionData(type: "image", content: "location_icon"),
                RowMainDescriptionData(type: "text", content: "598m"),
                RowMainDescriptionData(type: "text", content: " · "),
                RowMainDescriptionData(type: "image", content: "star_icon"),
                RowMainDescriptionData(type: "text", content: "4.3 (24)"),]
    }
    
    func getRightPrimaryLabel() -> String? {
        return "15%"
    }
    
    func getRightSecondaryLabel() -> String? {
        return "OFF"
    }
    
    func getRightMiddleLabel() -> String? {
        return "Tope de $100"
    }
    
    func getRightTopLabel() -> String? {
        return nil
    }
    
    func getRightLabelStatus() -> String? {
        return "BLOCKED"
    }
    
    func getRightBottomInfo() -> MLBusinessRowRightBottomInfoData? {
        return RowRightBottomInfoData()
    }
    
    func getLink() -> String? {
        return "mercadopago://scanqr"
    }
}

class RowMainDescriptionData: NSObject, MLBusinessRowMainDescriptionData {
    private let type: String
    private let content: String
    private let color: String?
    
    init(type:String, content: String, color: String? = nil) {
        self.type = type
        self.content = content
        self.color = color
    }
    
    
    func getType() -> String {
        return type
    }
    
    func getContent() -> String {
        return content
    }
    
    func getColor() -> String? {
        return color
    }
}

class RowRightBottomInfoData: NSObject, MLBusinessRowRightBottomInfoData {
    func getIcon() -> String? {
        return "clock_icon"
    }
    
    func getLabel() -> String? {
        return "¡ÚLTIMOS!"
    }
    
    func getFormat() -> MLBusinessRowRightBottomInfoFormatData? {
        return RowRightBottomInfoFormatData()
    }
}

class RowRightBottomInfoFormatData: NSObject, MLBusinessRowRightBottomInfoFormatData {
    func getTextColor() -> String {
        return "#FF0000"
    }
    
    func getBackgroundColor() -> String {
        return "#FFFFFF"
    }
}
