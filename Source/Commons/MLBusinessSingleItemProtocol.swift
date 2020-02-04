//
//  MLBusinessSingleItemProtocol.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/11/19.
//

import Foundation

@objc public protocol MLBusinessSingleItemProtocol: NSObjectProtocol {
    @objc func titleForItem() -> String
    @objc func subtitleForItem() -> String
    @objc func iconImageUrlForItem() -> String
    @objc func deepLinkForItem() -> String?
    @objc func trackIdForItem() -> String?
    @objc optional func eventDataForItem() -> [String : Any]?
}

