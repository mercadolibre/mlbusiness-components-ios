//
//  CoverCarouselData.swift
//  Example_BusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import MLBusinessComponents

class CoverCarouselData: NSObject, MLBusinessTouchpointsData {
    
    func getTouchpointId() -> String {
        return "BusinessComponents-Example"
    }
    
    func getTouchpointType() -> String {
        return "COVER_CAROUSEL"
    }
    
    func getTouchpointTracking() -> [String : Any] {
        return ["id" : "BusinessComponents-Example", "type" : "COVER_CAROUSEL"]
    }
    
    func getTouchpointContent() -> [String : Any] {
        let burger = "https://cdn2.cocinadelirante.com/sites/default/files/styles/gallerie/public/images/2018/05/hamburguesa-con-fondue-receta.jpg"
        let pizza = "https://gift-static.kxscdn.com/img/pizza-napolitana/pizza-napolitana.jpg"

        let cardModels = [getCoverCarouselModel(from: burger, and: RowData().asModel()),
                          getCoverCarouselModel(from: pizza, and: RowData().asModel()),
                          getCoverCarouselModel(from: burger, and: RowData().asModel()),
                          getCoverCarouselModel(from: pizza, and: RowData().asModel()),
                          getCoverCarouselModel(from: pizza, and: RowData().asModel()),
                          getCoverCarouselModel(from: burger, and: ClosedRowData().asModel())
        ]

        let carouselModel = MLBusinessCoverCarouselModel(items: cardModels,
                                                         carouselAnimation: nil)
        return carouselModel.asDictionary()
    }
    
    private func getCoverCarouselModel(from cover: String, and rowData: MLBusinessRowData) -> MLBusinessCoverCarouselItemModel {
        let content = MLBusinessCoverCarouselItemContentModel(cover: cover,
                                                              leftImage: rowData.getLeftImage(),
                                                              leftImageAccessory: rowData.getLeftImageAccessory(),
                                                              leftImageStatus: rowData.getLeftImageStatus?(),
                                                              mainTitle: rowData.getMainTitle(),
                                                              mainSubtitle: rowData.getMainSubtitle(),
                                                              mainDescription: getMainDescription(from: rowData),
                                                              mainSecondaryDescription: rowData.getMainSecondaryDescription?(),
                                                              statusDescription: rowData.getStatusDescription?(),
                                                              rightPrimaryLabel: rowData.getRightPrimaryLabel(),
                                                              rightSecondaryLabel: rowData.getRightSecondaryLabel(),
                                                              rightMiddleLabel: rowData.getRightMiddleLabel(),
                                                              rightTopLabel: rowData.getRightTopLabel(),
                                                              rightLabelStatus: rowData.getRightLabelStatus(),
                                                              rightBottomInfo: getRightBottomInfo(from: rowData))
        
        return MLBusinessCoverCarouselItemModel(content: content,
                                                link: nil,
                                                tracking: nil)
    }
    
    private func getMainDescription(from rowData: MLBusinessRowData) -> [MLBusinessRowMainDescription] {
        guard let mainDescription = rowData.getMainDescription() else { return [] }
        
        return mainDescription.map({
            MLBusinessRowMainDescription(type: $0.getType(), content: $0.getContent(), color: $0.getColor())
        })
    }
    
    private func getRightBottomInfo(from rowData: MLBusinessRowData) -> MLBusinessRowRightBottomInfo {
        let textColor = rowData.getRightBottomInfo()?.getFormat()?.getTextColor() ?? "#000000"
        let backgroundColor = rowData.getRightBottomInfo()?.getFormat()?.getBackgroundColor() ?? "#ffffff"
        
        let format = MLBusinessRowRightBottomInfoFormat(textColor: textColor,
                                                        backgroundColor: backgroundColor)
        
        return MLBusinessRowRightBottomInfo(icon: rowData.getRightBottomInfo()?.getIcon(),
                                                           label: rowData.getRightBottomInfo()?.getLabel(),
                                                           format: format)
    }
}
