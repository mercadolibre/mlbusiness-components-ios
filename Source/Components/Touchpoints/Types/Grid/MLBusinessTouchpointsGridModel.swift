//
//  MLBusinessTouchpointsGridModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

protocol ComponentTrackable {
    func getTrackables() -> [Trackable]?
}

protocol Trackable {
    var trackingId: String? { get }
    var eventData: MLBusinessCodableDictionary? { get }
}

class MLBusinessTouchpointsGridModel: NSObject, Codable {
    private let title: String?
    private let subtitle: String?
    private let items: [MLBusinessTouchpointsGridItemModel]

    init(title: String?, subtitle: String?, items: [MLBusinessTouchpointsGridItemModel]) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.items = []
    }
}

extension MLBusinessTouchpointsGridModel: MLBusinessDiscountBoxData {
    func getTitle() -> String? {
        return title
    }

    func getSubtitle() -> String? {
        return subtitle
    }

    func getItems() -> [MLBusinessSingleItemProtocol] {
        return items
    }
}

extension MLBusinessTouchpointsGridModel: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return items
    }
}

class MLBusinessTouchpointsGridItemModel: NSObject, Codable {
    private let title: String
    private let subtitle: String
    private let image: String
    private let link: String?
    private let tracking: TouchpointsTrackingInfo?

    init(title: String, subtitle: String, image: String, link: String? = nil, tracking: TouchpointsTrackingInfo? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.link = link
        self.tracking = tracking
    }
}

extension MLBusinessTouchpointsGridItemModel: MLBusinessSingleItemProtocol {
    public func titleForItem() -> String {
        return title
    }
    
    public func subtitleForItem() -> String {
        return subtitle
    }
    
    public func iconImageUrlForItem() -> String {
        return image
    }
    
    public func deepLinkForItem() -> String? {
        return link
    }
    
    public func trackIdForItem() -> String? {
        return trackingId
    }
    
    public func eventDataForItem() -> [String : Any]? {
        return eventData?.rawValue
    }
}

extension MLBusinessTouchpointsGridItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

struct TouchpointsTrackingInfo: Codable & Trackable {
    let trackingId: String?
    let eventData: MLBusinessCodableDictionary?
}
