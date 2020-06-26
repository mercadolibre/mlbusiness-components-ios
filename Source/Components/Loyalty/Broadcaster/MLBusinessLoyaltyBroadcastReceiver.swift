//
//  MLBusinessLoyaltyBroadcastReceiver.swift
//  MLBusinessComponents
//
//  Created by contingencia on 6/26/20.
//

import UIKit

@objc public protocol MLBusinessLoyaltyBroadcastReceiver {
    func receiveInfo(_ loyaltyBroadcastData: MLBusinessLoyaltyBroadcastData) -> Bool
}
