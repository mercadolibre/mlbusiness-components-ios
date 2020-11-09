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

        let cardModels = [MLBusinessCoverCarouselItemModel(cover: burger, description: RowData().asModel()),
                          MLBusinessCoverCarouselItemModel(cover: pizza, description: RowData().asModel()),
                          MLBusinessCoverCarouselItemModel(cover: burger, description: RowData().asModel()),
                          MLBusinessCoverCarouselItemModel(cover: pizza, description: RowData().asModel()),
                          MLBusinessCoverCarouselItemModel(cover: pizza, description: RowData().asModel())
        ]

        let carouselModel = MLBusinessCoverCarouselModel(items: cardModels,
                                                         alphaAnimation: nil,
                                                         scaleAnimation: nil,
                                                         pressAnimation: nil)
        
        return carouselModel.asDictionary()
    }
}
