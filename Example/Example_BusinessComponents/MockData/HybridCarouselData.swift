//
//  HybridCarouselData.swift
//  Example_BusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import MLBusinessComponents

class HybridCarouselData: NSObject, MLBusinessTouchpointsData {
    
    func getTouchpointId() -> String {
        return "BusinessComponents-Example"
    }
    
    func getTouchpointType() -> String {
        return "HYBRID_CAROUSEL"
    }
    
    func getTouchpointTracking() -> [String : Any] {
        return ["id" : "BusinessComponents-Example", "type" : "HYBRID_CAROUSEL"]
    }
    
    func getTouchpointContent() -> [String : Any] {
        var items: [[String : Any]] = []
        
        for _ in 1...5 {
            items.append(createItem(topImage: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png",
                                    topImageAccessory: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png",
                                    topImageStatus: "AVAILABLE",
                                    middleTitle: "Starbucks",
                                    middleSubtitle: "Cafetería",
                                    bottomPrimaryLabel: "20%",
                                    bottomSecondaryLabel: "OFF",
                                    bottomLabelStatus: "BLOCKED",
                                    bottomInfoIcon: "discount_payers_lock",
                                    bottomInfoLabel: "¡ÚLTIMOS!",
                                    bottomInfoTextColor: "#ff7733",
                                    bottomInfoBackgroundColor: "#FFFFFF",
                                    link: "meli://home",
                                    tracking: createTrackingItem(trackingId: "1048784",
                                                                 blocked: false,
                                                                 name: "El Nomble")))
        }
        
        items.append(createItem(topImage: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png",
                                topImageAccessory: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png",
                                topImageStatus: "CLOSED",
                                middleTitle: "Starbucks",
                                middleSubtitle: "Cafetería",
                                bottomPrimaryLabel: "20%",
                                bottomSecondaryLabel: "OFF",
                                bottomLabelStatus: "CLOSED",
                                bottomInfoIcon: "discount_payers_lock",
                                bottomInfoLabel: "¡ÚLTIMOS!",
                                bottomInfoTextColor: "#ff7733",
                                bottomInfoBackgroundColor: "#FFFFFF",
                                link: "meli://home",
                                tracking: createTrackingItem(trackingId: "1048784",
                                                             blocked: false,
                                                             name: "El Nomble")))
        
        items.append(createViewMoreItem(mainImage: "https://upload.wikimedia.org/wikipedia/commons/b/b3/Logo-freddo.jpg",
                                        mainTitle: "Ver todos",
                                        link:  "meli://home",
                                        tracking: createTrackingItem(trackingId: "1048784",
                                                                     blocked: false,
                                                                     name: "El Nomble")))
                
        return ["title": "Nuevos", "subtitle": "Touchpoints", "items" : items] as [String : Any]
    }
    
    private func createItem(topImage: String, topImageAccessory: String, topImageStatus: String, middleTitle: String, middleSubtitle: String, bottomPrimaryLabel: String, bottomSecondaryLabel: String, bottomLabelStatus: String, bottomInfoIcon: String, bottomInfoLabel: String, bottomInfoTextColor: String, bottomInfoBackgroundColor: String, link: String, tracking: [String : Any]) -> [String : Any] {
        return ["type": "DEFAULT", "content": ["top_image" : topImage, "top_image_accessory" : topImageAccessory, "top_image_status" : topImageStatus, "middle_title" : middleTitle, "middle_subtitle" : middleSubtitle, "bottom_primary_label" : bottomPrimaryLabel, "bottom_secondary_label" : bottomSecondaryLabel, "bottom_label_status" : bottomLabelStatus, "bottom_info" : ["icon" : bottomInfoIcon, "label" : bottomInfoLabel, "format" : ["text_color" : bottomInfoTextColor, "background_color" : bottomInfoBackgroundColor]]],  "link" : link, "tracking" : tracking]
    }
    
    private func createViewMoreItem(mainImage: String, mainTitle: String, link: String, tracking: [String : Any]) -> [String : Any] {
        return ["type": "VIEW_MORE", "content": ["main_image" : mainImage, "main_title" : ["label" : mainTitle, "format" : ["text_color" : "#009ee3", "background_color" : "#00FFFFFF"]]],  "link" : link, "tracking" : tracking]
    }
    
    private func createTrackingItem(trackingId: String, blocked: Bool, name: String) -> [String : Any] {
        return ["tracking_id" : trackingId, "event_data" : ["blocked" : blocked, "name" : name, "tracking_id" : trackingId]]
    }
}
