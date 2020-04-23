//
//  MLBusinessTouchpointsGridModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

struct MLBusinessTouchpointsGridModel: Codable {
    let title: String?
    let subtitle: String?
    let items: [MLBusinessTouchpointsGridItemModel]
//    public let discountTracker: MLBusinessDiscountTrackerProtocol?
}

struct MLBusinessTouchpointsGridItemModel: Codable {
    let image: String
    let link: String?
    let title: String
    let subtitle: String
    let trackingId: String?
}
