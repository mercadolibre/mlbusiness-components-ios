//
//  MLBusinessCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 05/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselItemModel {
    public let cover: String
    public let description: MLBusinessRowData
    
    public init(cover: String, description: MLBusinessRowData) {
        self.cover = cover
        self.description = description
    }
}
