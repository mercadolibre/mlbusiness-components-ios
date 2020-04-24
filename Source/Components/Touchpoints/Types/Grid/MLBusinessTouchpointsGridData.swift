//
//  MLBusinessTouchpointsGridData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 23/04/2020.
//

import Foundation

class MLBusinessTouchpointsGridData: NSObject {
    private var title: String?
    private var subtitle: String?
    private var items: [MLBusinessSingleItemProtocol]
    private let trackingProvider: MLBusinessDiscountTrackerProtocol?

    public init(title: String? = nil, subtitle: String? = nil, items: [MLBusinessSingleItemProtocol], trackingProvider: MLBusinessDiscountTrackerProtocol? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
        self.trackingProvider = trackingProvider
    }
}

extension MLBusinessTouchpointsGridData: MLBusinessDiscountBoxData {
    func getTitle() -> String? {
        return title
    }
    
    func getSubtitle() -> String? {
        return subtitle
    }
    
    func getItems() -> [MLBusinessSingleItemProtocol] {
        return items
    }
    
    func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol? {
        return trackingProvider
    }
}
