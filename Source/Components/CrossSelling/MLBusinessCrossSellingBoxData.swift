//
//  MLBusinessCrossSellingBoxData.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 16/09/2019.
//

import Foundation

@objc public protocol MLBusinessCrossSellingBoxData: NSObjectProtocol {
    @objc func getIconUrl() -> String
    @objc func getText() -> String
    @objc func getButtonTitle() -> String
    @objc func getButtonDeepLink() -> String
}
