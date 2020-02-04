//
//  SingleItemData.swift
//  Example_BusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/11/19.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class SingleItemData: NSObject {
    let title: String
    let subTitle: String
    let iconUrl: String
    let deepLink: String?
    let trackId: String?
    let eventData: [String : Any]?

    init(title: String, subtitle: String, iconImageUrl: String, deepLink: String? = nil, trackId: String? = nil, eventData: [String : Any]? = nil) {
        self.title = title
        self.subTitle = subtitle
        self.iconUrl = iconImageUrl
        self.deepLink = deepLink
        self.trackId = trackId
        self.eventData = eventData
    }
}

extension SingleItemData: MLBusinessSingleItemProtocol {
    func titleForItem() -> String {
        return title
    }

    func subtitleForItem() -> String {
        return subTitle
    }

    func iconImageUrlForItem() -> String {
        return iconUrl
    }

    func deepLinkForItem() -> String? {
        return deepLink
    }

    func trackIdForItem() -> String? {
        return trackId
    }
    
    func eventDataForItem() -> [String : Any]? {
        return eventData
    }
}
