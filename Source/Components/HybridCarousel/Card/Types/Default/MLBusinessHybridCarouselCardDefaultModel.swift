//
//  MLBusinessHybridCarouselCardDefaultModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

public class MLBusinessHybridCarouselCardDefaultModel: NSObject, Codable {
    let topImage: String?
    let topImageAccessory: String?
    let middleTitle: String?
    let middleSubtitle: String?
    let bottomTopLabel: String?
    let bottomPrimaryLabel: String?
    let bottomSecondaryLabel: String?
    let bottomLabelStatus: String?
    let bottomInfo: MLBusinessHybridCarouselBottomInfoModel?
    let link: String?
    let tracking: MLBusinessHybridCarouselCardModelTracking?
    
    public init (topImage: String?, topImageAccessory: String?, middleTitle: String?, middleSubtitle: String?, bottomTopLabel: String?, bottomPrimaryLabel: String?, bottomSecondaryLabel: String?, bottomLabelStatus: String?, bottomInfo: MLBusinessHybridCarouselBottomInfoModel?, link: String?, tracking: MLBusinessHybridCarouselCardModelTracking?) {
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

extension MLBusinessHybridCarouselCardDefaultModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

public class MLBusinessHybridCarouselBottomInfoModel: NSObject, Codable {
    let label: String
    let icon: String?
    let format: MLBusinessHybridCarouselBottomInfoFormatModel
    
    public init(label: String, icon: String?, format: MLBusinessHybridCarouselBottomInfoFormatModel) {
        self.label = label
        self.icon = icon
        self.format = format
    }
}

public class MLBusinessHybridCarouselBottomInfoFormatModel: NSObject, Codable {
    let backgroundColor: String
    let textColor: String
    
    public init(backgroundColor: String, textColor: String) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}
