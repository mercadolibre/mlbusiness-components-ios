//
//  MLBusinessLoyaltyRingData.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/28/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit

@objc public protocol MLBusinessLoyaltyRingData: NSObjectProtocol {
    @objc optional func getRingHexaColor() -> String
    @objc optional func getRingNumber() -> Int
    @objc optional func getRingPercentage() -> Float
    @objc func getTitle() -> String
    @objc optional func getSubtitle() -> String
    @objc func getButtonTitle() -> String
    @objc func getButtonDeepLink() -> String
    @objc optional func getImageUrl() -> String
}
