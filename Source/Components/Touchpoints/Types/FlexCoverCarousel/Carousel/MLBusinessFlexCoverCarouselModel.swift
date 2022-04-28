//
//  MLBusinessFlexCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import Foundation

class MLBusinessFlexCoverCarouselModel: NSObject, Codable{
    
    public let items: [MLBusinessFlexCoverCarouselItemModel]
    
    public init(items: [MLBusinessFlexCoverCarouselItemModel]){
        self.items = items
    }
}

