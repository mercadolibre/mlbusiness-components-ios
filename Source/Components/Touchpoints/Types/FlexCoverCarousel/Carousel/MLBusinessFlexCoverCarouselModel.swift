//
//  MLBusinessFlexCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import Foundation

struct MLBusinessFlexCoverCarouselModel: Codable{
    
    public let items: [MLBusinessFlexCoverCarouselItemModel]
    
    public init(items: [MLBusinessFlexCoverCarouselItemModel]){
        self.items = items
    }
}

extension MLBusinessFlexCoverCarouselModel: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        items
    }
}
