//
//  MLBusinessTouchpointsData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 23/04/2020.
//

import Foundation

@objc public protocol MLBusinessTouchpointsData: NSObjectProtocol {
    @objc func getType() -> String
    @objc func getContent() -> [String : Any]
    @objc optional func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol?
    //delegate para PRINTS
}
