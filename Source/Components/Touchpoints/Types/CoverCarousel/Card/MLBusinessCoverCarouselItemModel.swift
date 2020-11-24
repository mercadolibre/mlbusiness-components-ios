//
//  MLBusinessCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 05/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselItemModel: Codable {
    public let content: MLBusinessCoverCarouselItemContentModel?
    public let link: String?
    public let tracking: MLBusinessItemModelTracking?
    
    public init(content: MLBusinessCoverCarouselItemContentModel?,
                link: String?,
                tracking: MLBusinessItemModelTracking?) {
        self.content = content
        self.link = link
        self.tracking = tracking
    }
    
    public func getTrackingId() -> String? {
        return trackingId
    }
    
    public func getEventData() -> [String : Any]? {
        return eventData?.rawValue
    }
}

extension MLBusinessCoverCarouselItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }
    
    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

public struct MLBusinessCoverCarouselItemContentModel: Codable {
    public let cover: String?
    public let leftImage: String?
    public let leftImageAccessory: String?
    public let mainTitle: String
    public let mainSubtitle: String?
    public let mainDescription: [MLBusinessRowMainDescription]?
    public let mainSecondaryDescription: [MLBusinessMultipleDescriptionModel]?
    public let rightPrimaryLabel: String?
    public let rightSecondaryLabel: String?
    public let rightMiddleLabel: String?
    public let rightTopLabel: String?
    public let rightLabelStatus: String?
    public let rightBottomInfo: MLBusinessRowRightBottomInfo?
    
    public init(cover: String?,
                leftImage: String?,
                leftImageAccessory: String?,
                mainTitle: String,
                mainSubtitle: String?,
                mainDescription: [MLBusinessRowMainDescription]?,
                mainSecondaryDescription: [MLBusinessMultipleDescriptionModel]?,
                rightPrimaryLabel: String?,
                rightSecondaryLabel: String?,
                rightMiddleLabel: String?,
                rightTopLabel: String?,
                rightLabelStatus: String?,
                rightBottomInfo: MLBusinessRowRightBottomInfo?) {
        self.cover = cover
        self.leftImage = leftImage
        self.leftImageAccessory = leftImageAccessory
        self.mainTitle = mainTitle
        self.mainSubtitle = mainSubtitle
        self.mainDescription = mainDescription
        self.mainSecondaryDescription = mainSecondaryDescription
        self.rightPrimaryLabel = rightPrimaryLabel
        self.rightSecondaryLabel = rightSecondaryLabel
        self.rightMiddleLabel = rightMiddleLabel
        self.rightTopLabel = rightTopLabel
        self.rightLabelStatus = rightLabelStatus
        self.rightBottomInfo = rightBottomInfo
    }
}
