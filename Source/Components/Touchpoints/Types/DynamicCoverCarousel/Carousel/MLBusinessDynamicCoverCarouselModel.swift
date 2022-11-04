//
//  MLBusinessDynamicCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 02/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselModel: Codable {
    
    public let items: [MLBusinessDynamicCoverCarouselItemModel]
    
    public init(items: [MLBusinessDynamicCoverCarouselItemModel]){
        self.items = items
    }
}
