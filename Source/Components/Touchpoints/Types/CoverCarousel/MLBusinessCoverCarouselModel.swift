//
//  MLBusinessCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselModel: Codable {
    public let items: [MLBusinessCoverCarouselItemModel]
    
    public init(items: [MLBusinessCoverCarouselItemModel]) {
        self.items = items
    }
}
