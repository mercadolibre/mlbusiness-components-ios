//
//  MLBusinessCoverCarouselItemModelTracking.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselItemModelTracking: Codable {
    let trackingId: String?
    let eventData: MLBusinessCodableDictionary?

    public init(trackingId: String?, eventData: [String: Any]?) {
        self.trackingId = trackingId
        if let eventData = eventData {
            self.eventData = MLBusinessCodableDictionary(value: eventData)
        } else {
            self.eventData = nil
        }
    }
}
