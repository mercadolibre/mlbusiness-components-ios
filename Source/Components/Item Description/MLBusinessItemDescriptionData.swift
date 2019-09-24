//
//  MLBusinessItemDescriptionData.swift
//  MLBusinessComponents
//
//  Created by Nicolas Battelli on 18/09/2019.
//

import UIKit

@objc public protocol MLBusinessItemDescriptionData: NSObjectProtocol {
    @objc func getTitle() -> String
    @objc func getIconImageURL() -> String
    @objc func getIconHexaColor() -> String
}
