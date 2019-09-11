//
//  MLBusinessDiscountSingleItem.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/29/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import Foundation

@objc open class MLBusinessDiscountSingleItem: NSObject {
    let title: String
    let subtitle: String
    let iconImageUrl: String
    let deepLink: String?
    let trackId: String?

    public init(title: String, subtitle: String, iconImageUrl: String, deepLink: String? = nil, trackId: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.iconImageUrl = iconImageUrl
        self.deepLink = deepLink
        self.trackId = trackId
    }
}
