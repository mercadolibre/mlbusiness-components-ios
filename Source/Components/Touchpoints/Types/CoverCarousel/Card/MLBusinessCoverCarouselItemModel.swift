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
    public let tracking: MLBusinessCoverCarouselItemModelTracking?

    public init(cover: String?, description: MLBusinessMultipleRowItemModel?, tracking: MLBusinessCoverCarouselItemModelTracking?) {
        self.cover = cover
        self.description = description
        self.tracking = tracking
    }
}

extension MLBusinessCoverCarouselItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}
