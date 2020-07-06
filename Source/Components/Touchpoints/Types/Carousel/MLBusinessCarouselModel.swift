//
//  MLBusinessCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

class MLBusinessCarouselModel: NSObject, Codable, ComponentTrackable {
    private let title: String?
    private let subtitle: String?
    private let items: [MLBusinessCarouselItemModel]

    init(title: String?, subtitle: String?, items: [MLBusinessCarouselItemModel]) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.items = []
    }
    
    func getTrackables() -> [Trackable]? {
        return items
    }
    
    func getItems() -> [MLBusinessCarouselItemModel] {
        return items
    }
}

public class MLBusinessCarouselItemModel: NSObject, Codable {
    let title: String?
    let topLabel: String?
    let mainLabel: String?
    let rightLabel: String?
    let pill: DiscountItemDiscountPill?
    let image: String?
    let subtitle: String?
    let link: String?
    let textColor: String?
    let backgroundColor: String?
    let tracking: TrackingInfo?
    
    let titleFormat: DiscountItemTextFormat?
    let subtitleFormat: DiscountItemTextFormat?
    let imageFormat: DiscountItemImageFormat?

    public func getLink() -> String? {
        return link
    }
    
    public func getTrackingId() -> String? {
        return trackingId
    }
    
    public func getEventData() -> [String : Any]? {
        return eventData?.rawValue
    }
    
    public init (title: String?, topLabel: String?, mainLabel: String?, rightLabel: String?, pill: DiscountItemDiscountPill?, image: String?, subtitle: String?, link: String?, textColor: String?, backgroundColor: String?, tracking: TrackingInfo?, titleFormat: DiscountItemTextFormat?, subtitleFormat: DiscountItemTextFormat?, imageFormat: DiscountItemImageFormat?) {
        self.title = title
        self.topLabel = topLabel
        self.mainLabel = mainLabel
        self.rightLabel = rightLabel
        self.pill = pill
        self.image = image
        self.subtitle = subtitle
        self.link = link
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.tracking = tracking
        self.titleFormat = titleFormat
        self.subtitleFormat = subtitleFormat
        self.imageFormat = imageFormat
    }
}

extension MLBusinessCarouselItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

public class DiscountItemDiscountPill: NSObject, Codable {
    let label: String
    let icon: String?
    let format: DiscountItemDiscountFeatureFormat
    
    public init(label: String, icon: String?, format: DiscountItemDiscountFeatureFormat) {
        self.label = label
        self.icon = icon
        self.format = format
    }
}

public class DiscountItemDiscountFeatureFormat: NSObject, Codable {
    let backgroundColor: String
    let textColor: String
    
    public init(backgroundColor: String, textColor: String) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}

public class DiscountItemTextFormat: NSObject, Codable {
    let size: Double
    let color: String
    let weight: String

    public init(size: Double, color: String, weight: String) {
        self.size = size
        self.color = color
        self.weight = weight
    }
}

public class DiscountItemImageFormat: NSObject, Codable {
    let overlay: Bool
    
    public init(overlay: Bool) {
        self.overlay = overlay
    }
}
