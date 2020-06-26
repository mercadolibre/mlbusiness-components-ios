//
//  MLBusinessLoyaltyBroadcaster.swift
//  MLBusinessComponents
//
//  Created by Guido Maceira on 6/26/20.
//

import Foundation

@objcMembers
open class MLBusinessLoyaltyBroadcaster : NSObject {

    private static let instance = MLBusinessLoyaltyBroadcaster();
    
    public static func getInstance() -> MLBusinessLoyaltyBroadcaster {
        return instance;
    }
    
    public static func register(_ receiver: MLBusinessLoyaltyBroadcastReceiver) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiver.receiveInfo(_:)),
                                               name: Notification.Name("NotificationIdentifier"),
                                               object: receiver)
    }
    
    public static func unregister(_ receiver: MLBusinessLoyaltyBroadcastReceiver) {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name("NotificationIdentifier"),
                                                  object: receiver)
    }
    
    public static func updateInfo(_ loyaltyBroadcastData: MLBusinessLoyaltyBroadcastData){
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    
}
