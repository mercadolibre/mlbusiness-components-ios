//
//  MLBusinessRowModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 20/07/2020.
//

import Foundation

public struct MLBusinessRowModel: Codable {
    let leftImage: String?
    let leftImageAccessory: String?
    let mainTitle: String
    let mainSubtitle: String?
    let mainDescription: [MLBusinessRowMainDescriptionModel]?
    let rightPrimaryLabel: String?
    let rightSecondaryLabel: String?
    let rightMiddleLabel: String?
    let rightTopLabel: String?
    let rightLabelStatus: String?
    let rightBottomInfo: MLBusinessRowRightBottomInfoModel?
    let link: String?
}

struct MLBusinessRowMainDescriptionModel: Codable {
    let type: String
    let content: String
    let color: String?
}

struct MLBusinessRowRightBottomInfoModel: Codable {
    let icon: String?
    let label: String
    let format: MLBusinessRowRightBottomInfoFormatModel?
}

struct MLBusinessRowRightBottomInfoFormatModel: Codable {
    let textColor: String
    let backgroundColor: String
}
