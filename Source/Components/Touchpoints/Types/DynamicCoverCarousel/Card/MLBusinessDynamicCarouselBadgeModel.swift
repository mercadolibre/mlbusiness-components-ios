//
//  MLBusinessDynamicCarouselBadgeModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCarouselBadgeModel: Codable {
    private let backgroundColor: String?
    private let content: [MLBusinessMultipleDescriptionModel]?
    
    public init(backgroundColor: String?,
                content: [MLBusinessMultipleDescriptionModel]?) {
        self.backgroundColor = backgroundColor
        self.content = content
    }
    
    public func getBackgraundColor() -> String? {
        return backgroundColor
    }
    
    public func getContent() -> [MLBusinessMultipleDescriptionModel]? {
        return content
    }
}
