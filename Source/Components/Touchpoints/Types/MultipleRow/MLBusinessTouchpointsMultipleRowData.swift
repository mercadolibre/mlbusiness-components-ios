//
//  MLBusinessTouchpointsMultipleRowData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 12/08/2020.
//

import Foundation

@objc public protocol MLBusinessTouchpointsMultipleRowData: NSObjectProtocol {
    @objc optional func getTitle() -> String?
    @objc optional func getSubtitle() -> String?
    @objc func getItems() -> [MLBusinessMultipleRowItemModel]
    @objc optional func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol?
}
