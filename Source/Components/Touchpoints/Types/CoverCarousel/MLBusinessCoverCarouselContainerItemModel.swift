//
//  MLBusinessCoverCarouselContainerItemModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 05/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselContainerItemModel {
    public init(row: MLBusinessRowData, coverImage: String) {
        self.row = row
        self.coverImage = coverImage
    }
    
    public let row: MLBusinessRowData
    public let coverImage: String
}
