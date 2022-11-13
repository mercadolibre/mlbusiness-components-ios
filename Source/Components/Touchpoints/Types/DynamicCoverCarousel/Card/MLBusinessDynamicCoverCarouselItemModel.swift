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
    public let topContent: [MLBusinessMultipleDescriptionModel]?
    public let mainDescriptionLeft: [MLBusinessMultipleDescriptionModel]?
    public let mainDescriptionRight: [MLBusinessMultipleDescriptionModel]?
    public let mainSecondaryDescription: [MLBusinessMultipleDescriptionModel]?
    public let footerContent: MLBusinessDynamicCoverCarouselFooterModel?
    
    public init(backgroundColor: String?,
                imageHeader: String,
                link: String,
                topContent: [MLBusinessMultipleDescriptionModel]?,
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
}
