//
//  MLBusinessLoyaltyRingData.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/28/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit

public protocol MLBusinessLoyaltyRingData {
    @available(*, deprecated, message: "Use optional getRingHexaColor() instead")
    func getRingHexaColor() -> String
    @available(*, deprecated, message: "Use NSNumber getRingNumber() instead")
    func getRingNumber() -> Int
    @available(*, deprecated, message: "Use NSNumber getRingPercentage() instead")
    func getRingPercentage() -> Float
    @available(*, deprecated, message: "Use optional getSubtitle() instead")
    func getSubtitle() -> String
    @available(*, deprecated, message: "Use optional getButtonTitle() instead")
    func getButtonTitle() -> String
    @available(*, deprecated, message: "Use optional getButtonDeepLink() instead")
    func getButtonDeepLink() -> String
    
    func getRingHexaColor() -> String?
    func getRingNumber() -> NSNumber?
    func getRingPercentage() -> NSNumber?
    func getTitle() -> String
    func getSubtitle() -> String?
    func getButtonTitle() -> String?
    func getButtonDeepLink() -> String?
    func getImageUrl() -> String?
}

public extension MLBusinessLoyaltyRingData {
    
    func getRingHexaColor() -> String { "" }
    func getRingHexaColor() -> String? {
        let value: String = getRingHexaColor()
        return value
    }
    
    func getRingNumber() -> Int { 0 }
    func getRingNumber() -> NSNumber? {
        let value: Int = getRingNumber()
        return value == 0 ? nil : NSNumber(value: value)
    }
    
    func getRingPercentage() -> Float { 0.0 }
    func getRingPercentage() -> NSNumber? {
        let value: Float = getRingPercentage()
        return value == 0.0 ? nil : NSNumber(value: value)
    }
    
    func getSubtitle() -> String { "" }
    func getSubtitle() -> String? {
        let value: String = getSubtitle()
        return value.isEmpty ? nil : value
    }
    
    func getButtonTitle() -> String { "" }
    func getButtonTitle() -> String? {
        let value: String = getButtonTitle()
        return value.isEmpty ? nil : value
    }
    
    func getButtonDeepLink() -> String { "" }
    func getButtonDeepLink() -> String? {
        let value: String = getButtonDeepLink()
        return value.isEmpty ? nil : value
    }
    
    func getImageUrl() -> String? { nil }
}
