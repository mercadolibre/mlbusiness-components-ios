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
        let topContentImage = MLBusinessMultipleDescriptionModel(type: "image", content: "discount_payers_icon_rating", color: "#FF7733")
        let topContentText = MLBusinessMultipleDescriptionModel(type: "text", content: "4.3", color: "#FF7733", style: MlBusinessMultipleDescriptionStyleModel(fontWeight: "semibold"))
        let topContent = MLBusinessDynamicCarouselBadgeModel(backgroundColor: "#FFF2EB", content: [topContentImage, topContentText])
        let leftContent = MLBusinessMultipleDescriptionModel(type: "text", content: "Sushi pop", color: "#ffffff", compressible: false)
        let mainDescription1 = MLBusinessMultipleDescriptionModel(type: "text", content: "30-45 min", color: "#ffffff", compressible: false)
        let mainDescription2 = MLBusinessMultipleDescriptionModel(type: "text", content: ".", color: "#ffffff", compressible: false)
        let mainDescription3 = MLBusinessMultipleDescriptionModel(type: "text", content: "Envío gratis", color: "#ffffff", compressible: false)
        let footerContent = MLBusinessDynamicCoverCarouselFooterModel(backgroundColor: "#FF656F", text: "Hasta 17% off", textColor: "#ffffff")
        
        let item = MLBusinessDynamicCoverCarouselItemModel(backgroundColor: nil,
                                                           imageHeader: "https://http2.mlstatic.com/D_NQ_NP_999357-MLA51851081854_102022-F.jpg",
                                                           link: ",m,nm,n",
                                                           topContent: [topContent],
                                                           mainDescriptionLeft: [leftContent],
                                                           mainDescriptionRight: [topContentImage, topContentText],
                                                           mainSecondaryDescription: [mainDescription1, mainDescription2, mainDescription3],
                                                           footerContent: footerContent)
        
        let carouselModel = MLBusinessDynamicCoverCarouselModel(type: "landscape", items: [item, item, item])
        
        return carouselModel.asDictionary()
    }
}

