//
//  DynamicCoverCarouselData.swift
//  Example_BusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import MLBusinessComponents

class DynamicCoverCarouselData: NSObject, MLBusinessTouchpointsData {
    func getTouchpointId() -> String {
        return "BusinessComponents-Example"
    }
    
    func getTouchpointType() -> String {
        return "DYNAMIC_COVER_CAROUSEL"
    }
    
    func getTouchpointContent() -> [String : Any] {
        let topContent = MLBusinessDynamicCarouselContentModel(type: "badge", content: "Cierra pronto", color: "white", background: nil, compressible: nil)
        let leftContent = MLBusinessDynamicCarouselContentModel(type: "text", content: "Sushi pop", color: "#ffffff", background: nil, compressible: false)
        let rightContent1 = MLBusinessDynamicCarouselContentModel(type: "image", content: "instore_review_filled_star", color: "#009EE3", background: nil, compressible: false)
        let rightContent2 = MLBusinessDynamicCarouselContentModel(type: "text", content: "4.7", color: "#ffffff", background: nil, compressible: false)
        let mainDescription1 = MLBusinessDynamicCarouselContentModel(type: "text", content: "30-45 min", color: "#ffffff", background: nil, compressible: false)
        let mainDescription2 = MLBusinessDynamicCarouselContentModel(type: "text", content: ".", color: "#ffffff", background: nil, compressible: false)
        let mainDescription3 = MLBusinessDynamicCarouselContentModel(type: "text", content: "Envío gratis", color: "#ffffff", background: nil, compressible: false)
        let footerContent = MLBusinessDynamicCoverCarouselFooterModel(backgroundColor: "#FF656F", text: "Hasta 17% off", textColor: "#ffffff")
        
        let item = MLBusinessDynamicCoverCarouselItemModel(backgroundColor: nil,
                                                           imageHeader: "bnbn",
                                                           link: ",m,nm,n",
                                                           topContent: [topContent],
                                                           leftContent: [leftContent],
                                                           rightContent: [rightContent1, rightContent2],
                                                           mainDescription: [mainDescription1, mainDescription2, mainDescription3],
                                                           footerContent: footerContent)
        
        let carouselModel = MLBusinessDynamicCoverCarouselModel(type: "landscape", items: [item, item, item])
        
        return carouselModel.asDictionary()
    }
}

