//
//  MLBusinessActionCardViewData.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 19/06/2020.
//

import Foundation

@objc public protocol MLBusinessActionCardViewData: NSObjectProtocol {
    @objc func getTitle() -> String
    @objc func getTitleColor() -> String
    @objc func getTitleBackgroundColor() -> String
    @objc func getTitleWeight() -> String
    @objc func getImageUrl() -> String
    @objc func getAffordanceText() -> String
}
