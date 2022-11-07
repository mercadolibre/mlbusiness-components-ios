//
//  MLBusinessDynamicCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselItemModel: Codable {
    private let backgroundColor: String?
    private let imageHeader: String
    private let link: String
    private let topContent: [MLBusinessDynamicCarouselContentModel]?
    private let leftContent: [MLBusinessDynamicCarouselContentModel]?
    private let rightContent: [MLBusinessDynamicCarouselContentModel]?
    private let mainDescription: [MLBusinessDynamicCarouselContentModel]?
    private let footerContent: MLBusinessDynamicCoverCarouselFooterModel?
    
    public init(backgroundColor: String?,
                imageHeader: String,
                link: String,
                topContent: [MLBusinessDynamicCarouselContentModel]?,
                leftContent: [MLBusinessDynamicCarouselContentModel]?,
                rightContent: [MLBusinessDynamicCarouselContentModel]?,
                mainDescription: [MLBusinessDynamicCarouselContentModel]?,
                footerContent: MLBusinessDynamicCoverCarouselFooterModel?) {
        
        self.backgroundColor = backgroundColor
        self.imageHeader = imageHeader
        self.link = link
        self.topContent = topContent
        self.leftContent = leftContent
        self.rightContent = rightContent
        self.mainDescription = mainDescription
        self.footerContent = footerContent
    }
}
