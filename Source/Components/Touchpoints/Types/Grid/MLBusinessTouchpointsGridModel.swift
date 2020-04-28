//
//  MLBusinessTouchpointsGridModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

class MLBusinessTouchpointsGridModel: NSObject, Codable {
    private let title: String?
    private let subtitle: String?
    private let items: [MLBusinessTouchpointsGridItemModel]

    init(title: String?, subtitle: String?, items: [MLBusinessTouchpointsGridItemModel]) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
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

class MLBusinessTouchpointsGridItemModel: NSObject, Codable {
    private let title: String
    private let subtitle: String
    private let image: String
    private let link: String?
    private let trackingId: String?

    init(title: String, subtitle: String, image: String, link: String? = nil, trackingId: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.link = link
        self.trackingId = trackingId
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
        return link
    }
    
    public func eventDataForItem() -> [String : Any]? {
        guard let trackingId = trackingId else { return nil }
        return ["tracking_id" : trackingId]
    }
}
