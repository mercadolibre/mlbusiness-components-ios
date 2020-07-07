//
//  MLBusinessLoyaltyBroadcastData.swift
//  MLBusinessComponents
//
//

@objcMembers
public class MLBusinessLoyaltyBroadcastData: NSObject {

    public let level: Int
    public let percentage: Double
    public let primaryColor: String

    public init(level: Int, percentage: Double, primaryColor: String) {
        self.level = level
        self.percentage = percentage
        self.primaryColor = primaryColor
    }

}
