//
//  MLBusinessDiscountTrackerProtocol.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 28/01/2020.
//

import Foundation

@objc public protocol MLBusinessDiscountTrackerProtocol: NSObjectProtocol {
    func track(action: String, eventData: [[String : Any]])
}
