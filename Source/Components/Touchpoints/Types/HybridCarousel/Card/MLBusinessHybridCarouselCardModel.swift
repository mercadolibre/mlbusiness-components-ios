//
//  MLBusinessHybridCarouselCardModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

public class MLBusinessHybridCarouselCardModel: NSObject, Codable {
    let type: String
    let content: MLBusinessCodableDictionary
    let tracking: MLBusinessHybridCarouselCardModelTracking?
    let link: String?

    public init(type: String, content: [String : Any], tracking: MLBusinessHybridCarouselCardModelTracking?, link: String?) {
        self.type = type
        self.content = MLBusinessCodableDictionary(value: content)
        self.tracking = tracking
        self.link = link
    }
    
    public func getTrackingId() -> String? {
        return trackingId
    }
    
    public func getEventData() -> [String : Any]? {
        return eventData?.rawValue
    }
    
    public func getLink() -> String? {
        return link
    }
}

public class MLBusinessHybridCarouselCardModelTracking: NSObject, Codable {
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

extension MLBusinessHybridCarouselCardModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

