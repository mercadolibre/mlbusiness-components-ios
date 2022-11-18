//
//  MLBusinessDynamicCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselItemModel: Codable {
    let backgroundColor: String?
    let imageHeader: String?
    let link: String?
    let topContent: [MLBusinessDynamicCarouselBadgeModel]?
    let mainDescriptionLeft: [MLBusinessMultipleDescriptionModel]?
    let mainDescriptionRight: [MLBusinessMultipleDescriptionModel]?
    let mainSecondaryDescription: [MLBusinessMultipleDescriptionModel]?
    let footerContent: MLBusinessDynamicCoverCarouselFooterModel?
    
    public init(backgroundColor: String?,
                imageHeader: String,
                link: String,
                topContent: [MLBusinessDynamicCarouselBadgeModel]?,
                mainDescriptionLeft: [MLBusinessMultipleDescriptionModel]?,
                mainDescriptionRight: [MLBusinessMultipleDescriptionModel]?,
                mainSecondaryDescription: [MLBusinessMultipleDescriptionModel]?,
                footerContent: MLBusinessDynamicCoverCarouselFooterModel?) {
        
        self.backgroundColor = backgroundColor
        self.imageHeader = imageHeader
        self.link = link
        self.topContent = topContent
        self.mainSecondaryDescription = mainSecondaryDescription
        self.mainDescriptionLeft = mainDescriptionLeft
        self.mainDescriptionRight = mainDescriptionRight
        self.footerContent = footerContent
    }
    
    public func getLink() -> String? {
        return link
    }
}
