//
//  MLBusinessDynamicCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 02/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselModel: Codable {
    private let type: String?
    
    private let items: [MLBusinessDynamicCoverCarouselItemModel]
    
    public init(type: String?,
                items: [MLBusinessDynamicCoverCarouselItemModel]){
        
        self.type = type
        self.items = items
    }
    
    public func getType() -> String? {
        return type
    }
    
    public func getItems() -> [MLBusinessDynamicCoverCarouselItemModel] {
        return items
    }
}

extension MLBusinessDynamicCoverCarouselModel: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return items
    }
}
