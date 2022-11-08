//
//  MLBusinessDynamicCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselItemModel: Codable {
    public let backgroundColor: String?
    public let imageHeader: String?
    public let link: String
    public let topContent: [MLBusinessDynamicCarouselContentModel]?
    public let mainDescription: [MLBusinessDynamicCarouselContentModel]?
    public let mainSecondaryDescription: [MLBusinessDynamicCarouselContentModel]?
    public let footerContent: MLBusinessDynamicCoverCarouselFooterModel?
    
    public init(backgroundColor: String?,
                imageHeader: String,
                link: String,
                topContent: [MLBusinessDynamicCarouselContentModel]?,
                mainDescription: [MLBusinessDynamicCarouselContentModel]?,
                mainSecondaryDescription: [MLBusinessDynamicCarouselContentModel]?,
                footerContent: MLBusinessDynamicCoverCarouselFooterModel?) {
        
        self.backgroundColor = backgroundColor
        self.imageHeader = imageHeader
        self.link = link
        self.topContent = topContent
        self.mainSecondaryDescription = mainSecondaryDescription
        self.mainDescription = mainDescription
        self.footerContent = footerContent
    }
}
