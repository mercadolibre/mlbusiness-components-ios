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
    private let subTitle: String
    private let iconImageUrl: String
    private let deepLink: String?
    private let trackId: String?
    
    init(title: String, subtitle: String, iconImageUrl: String, deepLink: String? = nil, trackId: String? = nil) {
        self.title = title
        self.subTitle = subtitle
        self.iconImageUrl = iconImageUrl
        self.deepLink = deepLink
        self.trackId = trackId
    }
}

extension MLBusinessTouchpointsGridItemModel: MLBusinessSingleItemProtocol {
    public func titleForItem() -> String {
        return title
    }
    
    public func subtitleForItem() -> String {
        return subTitle
    }
    
    public func iconImageUrlForItem() -> String {
        return iconImageUrl
    }
    
    public func deepLinkForItem() -> String? {
        return deepLink
    }
    
    public func trackIdForItem() -> String? {
        return trackId
    }
    
    public func eventDataForItem() -> [String : Any]? {
        guard let trackId = trackId else { return nil }
        return ["tracking_id" : trackId]
    }
}
