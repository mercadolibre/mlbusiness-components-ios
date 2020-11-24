//
//  MLBusinessCoverCarouselItemContentModelMapper.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 18/11/2020.
//

import Foundation

protocol MLBusinessCoverCarouselItemContentModelMapperProtocol {
    func map(from model: MLBusinessCoverCarouselItemContentModel) -> MLBusinessMultipleRowItemModel
}

class MLBusinessCoverCarouselItemContentModelMapper: MLBusinessCoverCarouselItemContentModelMapperProtocol {
    func map(from model: MLBusinessCoverCarouselItemContentModel) -> MLBusinessMultipleRowItemModel {
        return MLBusinessMultipleRowItemModel(leftImage: model.leftImage,
                                              leftImageAccessory: model.leftImageAccessory,
                                              mainTitle: model.mainTitle,
                                              mainSubtitle: model.mainSubtitle,
                                              mainDescription: model.mainDescription,
                                              mainSecondaryDescription: model.mainSecondaryDescription,
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
