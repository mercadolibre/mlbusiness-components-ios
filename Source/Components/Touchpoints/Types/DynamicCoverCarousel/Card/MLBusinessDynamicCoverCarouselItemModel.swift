//
//  MLBusinessDynamicCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselItemModel: Codable {
    private let type: String
    private let backgroundColor: String?
    private let imageHeader: String
    private let link: String
    private let topContent: [MLBusinessContentDynamicCarouselContentModel]?
    private let leftContent: [MLBusinessContentDynamicCarouselContentModel]?
    private let rightContent: [MLBusinessContentDynamicCarouselContentModel]?
    private let mainDescription: [MLBusinessContentDynamicCarouselContentModel]?
    private let footerContent: MLBusinessDynamicCoverCarouselFooterModel?
    private let tracking: MLBusinessItemModelTracking?
    
    public init(type: String,
                backgroundColor: String?,
                imageHeader: String,
                link: String,
                topContent: [MLBusinessContentDynamicCarouselContentModel]?,
                leftContent: [MLBusinessContentDynamicCarouselContentModel]?,
                rightContent: [MLBusinessContentDynamicCarouselContentModel]?,
                mainDescription: [MLBusinessContentDynamicCarouselContentModel]?,
                footerContent: MLBusinessDynamicCoverCarouselFooterModel?,
                tracking: MLBusinessItemModelTracking?) {
        
        self.type = type
        self.backgroundColor = backgroundColor
        self.imageHeader = imageHeader
        self.link = link
        self.topContent = topContent
        self.leftContent = leftContent
        self.rightContent = rightContent
        self.mainDescription = mainDescription
        self.tracking = tracking
        self.footerContent = footerContent
    }
}

extension MLBusinessDynamicCoverCarouselItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }
    
    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}
