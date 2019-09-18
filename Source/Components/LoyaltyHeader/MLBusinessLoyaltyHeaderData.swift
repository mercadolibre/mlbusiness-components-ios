//
//  MLBusinessLoyaltyHeaderData.swift
//  MLBusinessComponents
//
//  Created by Nicolas Battelli on 16/09/2019.
//

import UIKit

@objc public protocol MLBusinessLoyaltyHeaderData: NSObjectProtocol {
    @objc func getBackgroundHexaColor() -> String
    @objc func getPrimaryHexaColor() -> String
    @objc func getSecondaryHexaColor() -> String
    @objc func getRingNumber() -> Int
    @objc func getRingPercentage() -> Float
    @objc func getTitle() -> String
    @objc func getSubtitle() -> String
}
