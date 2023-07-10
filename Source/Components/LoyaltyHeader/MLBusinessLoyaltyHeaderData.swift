//
//  MLBusinessLoyaltyHeaderData.swift
//  MLBusinessComponents
//
//  Created by Nicolas Battelli on 16/09/2019.
//
import UIKit

public protocol MLBusinessLoyaltyHeaderData {
    func getBackgroundHexaColor() -> String
    @available(*, deprecated, message: "Use optional getPrimaryHexaColor() instead")
    func getPrimaryHexaColor() -> String
    func getPrimaryHexaColor() -> String?
    @available(*, deprecated, message: "Use optional getSecondaryHexaColor() instead")
    func getSecondaryHexaColor() -> String
    func getSecondaryHexaColor() -> String?
    @available(*, deprecated, message: "Use optional getRingNumber() instead")
    func getRingNumber() -> Int
    func getRingNumber() -> Int?
    @available(*, deprecated, message: "Use optional getRingPercentage() instead")
    func getRingPercentage() -> Float
    func getRingPercentage() -> Float?
    @available(*, deprecated, message: "Use optional getTitle() instead")
    func getTitle() -> String
    func getTitle() -> String?
    func getSubtitle() -> String
}

public extension MLBusinessLoyaltyHeaderData {
    func getPrimaryHexaColor() -> String { "" }
    func getPrimaryHexaColor() -> String? {
        let value: String = getPrimaryHexaColor()
        return value.isEmpty ? nil : value
    }
    
    func getSecondaryHexaColor() -> String { "" }
    func getSecondaryHexaColor() -> String? {
        let value: String = getSecondaryHexaColor()
        return value.isEmpty ? nil : value
    }
    
    
    func getRingNumber() -> Int { 0 }
    func getRingNumber() -> Int? {
        let value: Int = getRingNumber()
        return value == 0 ? nil : value
    }
    
    func getRingPercentage() -> Float { 0.0 }
    func getRingPercentage() -> Float? {
        let value: Float = getRingPercentage()
        return value == 0.0 ? nil : value
    }

    func getTitle() -> String { "" }
    func getTitle() -> String? {
        let value: String = getTitle()
        return value.isEmpty ? nil : value
    }
}
