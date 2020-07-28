//
//  MLBusinessHybridCarouselCardData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 27/07/2020.
//
import Foundation

@objc public protocol MLBusinessHybridCarouselCardData: NSObjectProtocol {
    @objc func getTopImage() -> String?
    @objc func getTopImageAccessory() -> String?
    @objc func getMiddleTitle() -> String
    @objc func getMiddleSubtitle() -> String?
    @objc func getBottomTopLabel() -> String?
    @objc func getBottomPrimaryLabel() -> String?
    @objc func getBottomSecondaryLabel() -> String?
    @objc func getBottomLabelStatus() -> String?
    @objc func getBottomInfo() -> MLBusinessHybridCarouselCardBottomInfoData?
    @objc func getLink() -> String?
}


@objc public protocol MLBusinessHybridCarouselCardBottomInfoData: NSObjectProtocol {
    @objc func getIcon() -> String?
    @objc func getLabel() -> String?
    @objc func getFormat() -> MLBusinessHybridCarouselCardBottomInfoFormatData?
}

@objc public protocol MLBusinessHybridCarouselCardBottomInfoFormatData: NSObjectProtocol {
    @objc func getTextColor() -> String
    @objc func getBackgroundColor() -> String
}
