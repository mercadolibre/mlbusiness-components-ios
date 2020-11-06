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

        let mainDescription = RowData().getMainDescription()?.compactMap({
            return MLBusinessRowMainDescription(type: $0.getType(), content: $0.getContent(), color: $0.getColor())
        })

        let bottomInfo = MLBusinessRowRightBottomInfo(icon: RowData().getRightBottomInfo()?.getIcon(),
                                                      label: RowData().getRightBottomInfo()?.getLabel(),
                                                      format: MLBusinessRowRightBottomInfoFormat(textColor: (RowData().getRightBottomInfo()?.getFormat()?.getTextColor())!,
                                                                                                 backgroundColor: (RowData().getRightBottomInfo()?.getFormat()?.getBackgroundColor())!))

        let rowData = MLBusinessMultipleRowItemModel(leftImage: RowData().getLeftImage(),
                                                     leftImageAccessory: RowData().getLeftImageAccessory(),
                                                     mainTitle: RowData().getMainTitle(),
                                                     mainSubtitle: RowData().getMainSubtitle(),
                                                     mainDescription: mainDescription,
                                                     rightPrimaryLabel: RowData().getRightPrimaryLabel(),
                                                     rightSecondaryLabel: RowData().getRightSecondaryLabel(),
                                                     rightMiddleLabel: RowData().getRightMiddleLabel(),
                                                     rightTopLabel: RowData().getRightTopLabel(),
                                                     rightLabelStatus: RowData().getRightLabelStatus(),
                                                     rightBottomInfo: bottomInfo,
                                                     link: RowData().getLink(),
                                                     tracking: nil)

        let mainDescription2 = RowData2().getMainDescription()?.compactMap({
            return MLBusinessRowMainDescription(type: $0.getType(), content: $0.getContent(), color: $0.getColor())
        })

        let bottomInfo2 = MLBusinessRowRightBottomInfo(icon: RowData2().getRightBottomInfo()?.getIcon(),
                                                      label: RowData2().getRightBottomInfo()?.getLabel(),
                                                      format: MLBusinessRowRightBottomInfoFormat(textColor: (RowData2().getRightBottomInfo()?.getFormat()?.getTextColor())!,
                                                                                                 backgroundColor: (RowData2().getRightBottomInfo()?.getFormat()?.getBackgroundColor())!))

        let rowData2 = MLBusinessMultipleRowItemModel(leftImage: RowData2().getLeftImage(),
                                                     leftImageAccessory: RowData2().getLeftImageAccessory(),
                                                     mainTitle: RowData2().getMainTitle(),
                                                     mainSubtitle: RowData2().getMainSubtitle(),
                                                     mainDescription: mainDescription2,
                                                     rightPrimaryLabel: RowData2().getRightPrimaryLabel(),
                                                     rightSecondaryLabel: RowData2().getRightSecondaryLabel(),
                                                     rightMiddleLabel: RowData2().getRightMiddleLabel(),
                                                     rightTopLabel: RowData2().getRightTopLabel(),
                                                     rightLabelStatus: RowData2().getRightLabelStatus(),
                                                     rightBottomInfo: bottomInfo2,
                                                     link: RowData2().getLink(),
                                                     tracking: nil)

        let cardModels = [MLBusinessCoverCarouselItemModel(cover: burger, description: rowData, tracking: nil),
                          MLBusinessCoverCarouselItemModel(cover: pizza, description: rowData2, tracking: nil)
        ]

        let carouselModel = MLBusinessCoverCarouselModel(items: cardModels)

        return try! carouselModel.asDictionary()
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let strongDictionary = dictionary else {
                return [:]
        }
        
        return strongDictionary
    }
}
