//
//  MLBusinessTouchpointsData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 23/04/2020.
//

import Foundation

@objc public protocol MLBusinessTouchpointsData: NSObjectProtocol {
    @objc func getResponse() -> [String : Any]
    @objc optional func getTouchpointsTracker() -> MLBusinessDiscountTrackerProtocol?
    @objc optional func getPrints() -> [String : Any]
}
