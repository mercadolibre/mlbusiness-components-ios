//
//  MLBusinessLoyaltyBroadcastReceiver.swift
//  MLBusinessComponents
//
//  Created by Guido Maceira on 6/26/20.
//
import UIKit

@objc public protocol MLBusinessLoyaltyBroadcastReceiver {
    @objc func receiveInfo(_ notification: Notification)
}

