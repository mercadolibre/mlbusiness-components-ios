//
//  MLBusinessDynamicCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 02/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselModel: Codable {
    let type: String?
    
    let items: [MLBusinessDynamicCoverCarouselItemModel]
    
    public init(type: String?,
                items: [MLBusinessDynamicCoverCarouselItemModel]){
        
        self.type = type
        self.items = items
    }
}
