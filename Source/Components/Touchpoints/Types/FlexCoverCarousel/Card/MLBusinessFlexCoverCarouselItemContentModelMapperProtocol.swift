//
//  MLBusinessFlexCoverCarouselItemContentModelMapperProtocol.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import Foundation

protocol MLBusinessFlexCoverCarouselItemContentModelMapperProtocol {
    func map(from model: MLBusinessFlexCoverCarouselItemContentModel) -> MLBusinessMultipleRowItemModel
}

class MLBusinessCoverCarouselItemContentModelMapper: MLBusinessFlexCoverCarouselItemContentModelMapperProtocol {
    func map(from model: MLBusinessCoverCarouselItemContentModel) -> MLBusinessMultipleRowItemModel {
        return MLBusinessMultipleRowItemModel(leftImage: model.leftImage,
                                              leftImageAccessory: model.leftImageAccessory,
                                              leftImageStatus: model.leftImageStatus,
                                              mainTitle: model.mainTitle,
                                              mainTitleStatus: model.mainTitleStatus,
                                              mainSubtitle: model.mainSubtitle,
                                              mainDescription: model.mainDescription,
                                              mainSecondaryDescription: model.mainSecondaryDescription,
                                              statusDescription: model.statusDescription,
                                              rightPrimaryLabel: model.rightPrimaryLabel,
                                              rightSecondaryLabel: model.rightSecondaryLabel,
                                              rightMiddleLabel: model.rightMiddleLabel,
                                              rightTopLabel: model.rightTopLabel,
                                              rightLabelStatus: model.rightLabelStatus,
                                              rightBottomInfo: model.rightBottomInfo,
                                              link: nil,
                                              tracking: nil)
    }
}


