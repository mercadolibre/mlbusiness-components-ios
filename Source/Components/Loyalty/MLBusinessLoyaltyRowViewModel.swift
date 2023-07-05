//
//  MLBusinessLoyaltyRingViewModel.swift
//  MLBusinessComponents
//
//  Created by Guido Maceira on 13/06/2023.
//

import Foundation


class MLBusinessLoyaltyRowViewModel {
    private let loyaltyRowData: MLBusinessLoyaltyRingData
    
    init(loyaltyRowData: MLBusinessLoyaltyRingData) {
        self.loyaltyRowData = loyaltyRowData
    }
    
    func buttonShouldBeHidden() -> Bool {
        return loyaltyRowData.getButtonTitle?() == "" || loyaltyRowData.getButtonTitle?() == nil || loyaltyRowData.getButtonDeepLink?() == ""
    }
    
    func iconShouldBeHidden() -> Bool {
        return loyaltyRowData.getImageUrl?() == nil || loyaltyRowData.getImageUrl?() == ""
    }
    
    func ringShouldBeHidden() -> Bool {
        return loyaltyRowData.getRingNumber?() == nil || loyaltyRowData.getRingHexaColor?() == nil || loyaltyRowData.getRingPercentage?() == nil || loyaltyRowData.getRingNumber?() == nil
    }

    func getRingNumber() -> Int {
        return Int(truncating: loyaltyRowData.getRingNumber?() ?? 0)
    }
    
    func getRingCenterText() -> String {
        return getRingNumber() != 0 ? String(getRingNumber()) : ""
    }
    
    func getRingPercentage() -> Float {
        return Float(truncating: loyaltyRowData.getRingPercentage?() ?? 0)
    }
}
