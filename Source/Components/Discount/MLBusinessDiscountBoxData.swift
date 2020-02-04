//
//  MLBusinessDiscountBoxData.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/29/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import Foundation

@objc public protocol MLBusinessDiscountBoxData: NSObjectProtocol {
    @objc optional func getTitle() -> String?
    @objc optional func getSubtitle() -> String?
    @objc func getItems() -> [MLBusinessSingleItemProtocol]
    @objc optional func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol?
}
