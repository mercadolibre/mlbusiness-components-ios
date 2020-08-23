//
//  MLBusinessRowData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 21/07/2020.
//

import Foundation

@objc public protocol MLBusinessRowData: NSObjectProtocol {
    @objc func getLeftImage() -> String?
    @objc func getLeftImageAccessory() -> String?
    @objc func getMainTitle() -> String
    @objc func getMainSubtitle() -> String?
    @objc func getMainDescription() -> [MLBusinessRowMainDescriptionData]?
    @objc optional func getMainSecondaryDescription() -> [MLBusinessMultipleDescriptionModel]?
    @objc func getRightPrimaryLabel() -> String?
    @objc func getRightSecondaryLabel() -> String?
    @objc func getRightMiddleLabel() -> String?
    @objc func getRightTopLabel() -> String?
    @objc func getRightLabelStatus() -> String?
    @objc func getRightBottomInfo() -> MLBusinessRowRightBottomInfoData?
    @objc func getLink() -> String?
}

@objc public protocol MLBusinessRowMainDescriptionData: NSObjectProtocol {
    @objc func getType() -> String
    @objc func getContent() -> String
    @objc func getColor() -> String?
}

@objc public protocol MLBusinessRowRightBottomInfoData: NSObjectProtocol {
    @objc func getIcon() -> String?
    @objc func getLabel() -> String?
    @objc func getFormat() -> MLBusinessRowRightBottomInfoFormatData?
}

@objc public protocol MLBusinessRowRightBottomInfoFormatData: NSObjectProtocol {
    @objc func getTextColor() -> String
    @objc func getBackgroundColor() -> String
}
