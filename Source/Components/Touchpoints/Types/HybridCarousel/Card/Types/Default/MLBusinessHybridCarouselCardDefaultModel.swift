//
//  MLBusinessHybridCarouselCardDefaultModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

struct MLBusinessHybridCarouselCardDefaultModel: Codable {
    let topImage: String?
    let topImageAccessory: String?
    let middleTitle: String?
    let middleSubtitle: String?
    let bottomTopLabel: String?
    let bottomPrimaryLabel: String?
    let bottomSecondaryLabel: String?
    let bottomLabelStatus: String?
    let bottomInfo: MLBusinessHybridCarouselBottomInfoModel?
}

struct MLBusinessHybridCarouselBottomInfoModel: Codable {
    let label: String
    let icon: String?
    let format: MLBusinessHybridCarouselBottomInfoFormatModel
}

struct MLBusinessHybridCarouselBottomInfoFormatModel: Codable {
    let backgroundColor: String
    let textColor: String
}
