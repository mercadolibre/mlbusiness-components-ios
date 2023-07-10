//
//  MLBusinessLoyaltyBroadcastData.swift
//  MLBusinessComponents
//
//  Created by Guido Maceira on 6/26/20.
//

@objcMembers
public class MLBusinessLoyaltyBroadcastData: NSObject {

    public let level: Int
    public let percentage: Float
    public let primaryColor: String

    public init(level: Int?, percentage: Float?, primaryColor: String?) {
        self.level = level ?? 1
        self.percentage = percentage ?? 0.0
        self.primaryColor = primaryColor ?? "#FFFFFF"
    }

}
