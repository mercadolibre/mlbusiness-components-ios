//
//  MLBusinessTouchpointsData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 23/04/2020.
//

import Foundation

@objc public protocol MLBusinessTouchpointsData: NSObjectProtocol {
    @objc func getTouchpointId() -> String
    @objc func getTouchpointType() -> String
    @objc func getTouchpointContent() -> [String : Any]
    @objc optional func getTouchpointTracking() -> [String : Any]
    @objc optional func getAdditionalEdgeInsets() -> [String : Any]
}
