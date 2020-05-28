//
//  MLBusinessTouchpointsCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

class MLBusinessTouchpointsCarouselModel: NSObject, Codable, ComponentTrackable {
    private let title: String?
    private let subtitle: String?
    private let items: [MLBusinessTouchpointsCarouselItemModel]

    init(title: String?, subtitle: String?, items: [MLBusinessTouchpointsCarouselItemModel]) {
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
    
    func getItems() -> [MLBusinessTouchpointsCarouselItemModel] {
        return items
    }
}

struct MLBusinessTouchpointsCarouselItemModel: Codable, Trackable {
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
    let tracking: TouchpointsTrackingInfo?
    
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

public struct DiscountItemDiscountPill: Codable {
    public let label: String
    public let icon: String?
    public let format: DiscountItemDiscountFeatureFormat
}

public struct DiscountItemDiscountFeatureFormat: Codable {
    public let backgroundColor: String
    public let textColor: String
}
