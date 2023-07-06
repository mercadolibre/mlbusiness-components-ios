//
//  MLBusinessLoyaltyHeaderData.swift
//  MLBusinessComponents
//
//  Created by Nicolas Battelli on 16/09/2019.
//

import UIKit

public protocol MLBusinessLoyaltyHeaderData {
    func getBackgroundHexaColor() -> String
    func getPrimaryHexaColor() -> String?
    func getSecondaryHexaColor() -> String?
    func getRingNumber() -> Int?
    func getRingPercentage() -> Float?
    func getTitle() -> String?
    func getSubtitle() -> String
}
