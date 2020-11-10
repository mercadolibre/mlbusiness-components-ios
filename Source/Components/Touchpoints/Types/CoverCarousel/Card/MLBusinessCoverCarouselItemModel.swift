//
//  MLBusinessCoverCarouselItemModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 05/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselItemModel: Codable {
    public let cover: String?
    public let description: MLBusinessMultipleRowItemModel?

    public init(cover: String?, description: MLBusinessMultipleRowItemModel?) {
        self.cover = cover
        self.description = description
    }
}

extension MLBusinessCoverCarouselItemModel: Trackable {
    var trackingId: String? {
        return description?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return description?.eventData
    }
}
