//
//  MLBusinessHybridCarouselCardModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

public class MLBusinessHybridCarouselCardModel: NSObject, Codable {
    let topImage: String?
    let topImageAccessory: String?
    let middleTitle: String?
    let middleSubtitle: String?
    let bottomTopLabel: String?
    let bottomPrimaryLabel: String?
    let bottomSecondaryLabel: String?
    let bottomLabelStatus: String?
    let bottomInfo: HybridCarouselBottomInfo?
    let link: String?
    let tracking: MLBusinessHybridCarouselCardModelTracking?
    
    public init (topImage: String?, topImageAccessory: String?, middleTitle: String?, middleSubtitle: String?, bottomTopLabel: String?, bottomPrimaryLabel: String?, bottomSecondaryLabel: String?, bottomLabelStatus: String?, bottomInfo: HybridCarouselBottomInfo?, link: String?, tracking: MLBusinessHybridCarouselCardModelTracking?) {
        self.topImage = topImage
        self.topImageAccessory = topImageAccessory
        self.middleTitle = middleTitle
        self.middleSubtitle = middleSubtitle
        self.bottomTopLabel = bottomTopLabel
        self.bottomPrimaryLabel = bottomPrimaryLabel
        self.bottomSecondaryLabel = bottomSecondaryLabel
        self.bottomLabelStatus = bottomLabelStatus
        self.bottomInfo = bottomInfo
        self.link = link
        self.tracking = tracking
    }
}

extension MLBusinessHybridCarouselCardModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

public class HybridCarouselBottomInfo: NSObject, Codable {
    let label: String
    let icon: String?
    let format: HybridCarouselBottomInfoFormat
    
    public init(label: String, icon: String?, format: HybridCarouselBottomInfoFormat) {
        self.label = label
        self.icon = icon
        self.format = format
    }
}

public class HybridCarouselBottomInfoFormat: NSObject, Codable {
    let backgroundColor: String
    let textColor: String
    
    public init(backgroundColor: String, textColor: String) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}

public class MLBusinessHybridCarouselCardModelTracking: NSObject, Codable {
    let trackingId: String?
    let eventData: MLBusinessCodableDictionary?
    
    public init(trackingId: String?, eventData: [String: Any]?) {
        self.trackingId = trackingId
        if let eventData = eventData {
            self.eventData = MLBusinessCodableDictionary(value: eventData)
        } else {
            self.eventData = nil
        }
    }
}

extension MLBusinessHybridCarouselCardModelTracking: Trackable { }
