//
//  MLBusinessDynamicCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselItemModel: Codable {
    private let backgroundColor: String?
    private let imageHeader: String?
    private let link: String?
    private let topContent: [MLBusinessDynamicCarouselBadgeModel]?
    private let mainDescriptionLeft: [MLBusinessMultipleDescriptionModel]?
    private let mainDescriptionRight: [MLBusinessMultipleDescriptionModel]?
    private let mainSecondaryDescription: [MLBusinessMultipleDescriptionModel]?
    private let footerContent: MLBusinessDynamicCoverCarouselFooterModel?
    
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
    
    public func getBackgroundColor() -> String? {
        return backgroundColor
    }
    
    public func getImageHeader() -> String? {
        return imageHeader
    }
    
    public func getLink() -> String? {
        return link
    }
    
    public func getTopContent() -> [MLBusinessDynamicCarouselBadgeModel]? {
        return topContent
    }
    
    public func getMainDescriptionLeft() -> [MLBusinessMultipleDescriptionModel]? {
        return mainDescriptionLeft
    }
    
    public func getMainDescriptionRight() -> [MLBusinessMultipleDescriptionModel]? {
        return mainDescriptionRight
    }
    
    public func getMainSecondaryDescription() -> [MLBusinessMultipleDescriptionModel]? {
        return mainSecondaryDescription
    }
    
    public func getFooterContent() -> MLBusinessDynamicCoverCarouselFooterModel? {
        return footerContent
    }
}
