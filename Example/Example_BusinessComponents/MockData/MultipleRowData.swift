//
//  MultipleRowData.swift
//  Example_BusinessComponents
//
//  Created by Vicente Veltri on 12/08/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class MultipleRowData: NSObject, MLBusinessTouchpointsData {
    func getTouchpointId() -> String {
        return "BusinessComponents-Example"
    }
    
    func getTouchpointType() -> String {
        return "MULTIPLE_ROW"
    }
    
    func getTouchpointTracking() -> [String : Any] {
        return ["id" : "BusinessComponents-Example", "type" : "MULTIPLE_ROW"]
    }
    
    func getAdditionalEdgeInsets() -> [String : Any] {
        return ["top" : 16.0, "left" : 16.0, "right" : 16.0, "bottom" : 16.0]
    }
    
    func getTouchpointContent() -> [String : Any] {
        var items: [[String : Any]] = []
     
        let rowData = RowData()
        for _ in 1...2 {
            items.append(createItem(leftImage: rowData.getLeftImage() ?? "",
                                    leftImageAccessory: rowData.getLeftImageAccessory() ?? "",
                                    mainTitle: rowData.getMainTitle(),
                                    mainSubtitle: rowData.getMainSubtitle() ?? "",
                                    rightPrimaryLabel: rowData.getRightPrimaryLabel() ?? "",
                                    rightSecondaryLabel: rowData.getRightSecondaryLabel() ?? "",
                                    rightMiddleLabel: rowData.getRightMiddleLabel() ?? "",
                                    rightTopLabel: rowData.getRightTopLabel() ?? "",
                                    rightLabelStatus: rowData.getRightLabelStatus() ?? "",
                                    link: rowData.getLink() ?? "",
                                    tracking: createTrackingItem(trackingId: "1048784",
                                                                 blocked: false,
                                                                 name: "El Nomble")))
        }
        return ["title": "Nuevos", "subtitle": "Touchpoints", "items" : items] as [String : Any]
    }
    
    private func createItem(leftImage: String, leftImageAccessory: String, mainTitle: String, mainSubtitle: String, rightPrimaryLabel: String, rightSecondaryLabel: String, rightMiddleLabel: String, rightTopLabel: String, rightLabelStatus: String, link: String, tracking: [String : Any]) -> [String : Any] {
        return ["left_image" : leftImage, "left_image_accessory" : leftImageAccessory, "main_title" : mainTitle, "main_subtitle" : mainSubtitle, "right_primary_label" : rightPrimaryLabel, "right_secondary_label" : rightSecondaryLabel, "right_middle_label" : rightMiddleLabel, "right_top_label" : rightTopLabel, "right_label_status" : rightLabelStatus, "link" : link, "tracking" : tracking]
    }
    
    private func createTrackingItem(trackingId: String, blocked: Bool, name: String) -> [String : Any] {
        return ["tracking_id" : trackingId, "event_data" : ["blocked" : blocked, "name" : name, "tracking_id" : trackingId]]
    }
}
