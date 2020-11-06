//
//  MLBusinessCoverCarouselContainerItemModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 05/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselContainerItemModel {
    public init(row: MLBusinessRowData) {
        self.row = row
    }
    
    public let row: MLBusinessRowData
}
