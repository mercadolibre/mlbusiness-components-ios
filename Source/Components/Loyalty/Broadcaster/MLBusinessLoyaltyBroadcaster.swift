//
//  MLBusinessLoyaltyBroadcaster.swift
//  MLBusinessComponents
//
//  Created by Guido Maceira on 6/26/20.
//
import Foundation

@objcMembers
open class MLBusinessLoyaltyBroadcaster : NSObject {

    public static let instance = MLBusinessLoyaltyBroadcaster();
    private let notificationName = "LoyaltyBroadcaster";
    
    public func register(_ receiver: MLBusinessLoyaltyBroadcastReceiver) {
        NotificationCenter.default.addObserver(receiver,
                                               selector: #selector(receiver.receiveInfo(_:)),
                                               name: Notification.Name(rawValue: notificationName),
                                               object: nil)
    }
    
    public func unregister(_ receiver: MLBusinessLoyaltyBroadcastReceiver) {
        NotificationCenter.default.removeObserver(receiver,
                                                  name: Notification.Name(rawValue: notificationName),
                                                  object: nil)
    }
    
    public func updateInfo(_ loyaltyBroadcastData: MLBusinessLoyaltyBroadcastData){
        NotificationCenter.default.post(Notification(name: Notification.Name(notificationName), object: loyaltyBroadcastData))
    }
    
    
}
