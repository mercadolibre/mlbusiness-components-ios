//
//  MLBusinessHybridCarouselViewMoreCardModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

public class MLBusinessHybridCarouselViewMoreCardModel: NSObject, Codable {
    let mainImage: String?
    let mainTitle: MLBusinessHybridCarouselBottomInfoModel?
    let link: String?
    let tracking: MLBusinessHybridCarouselCardModelTracking?
    
    public init (mainImage: String?, mainTitle: MLBusinessHybridCarouselBottomInfoModel?, link: String?, tracking: MLBusinessHybridCarouselCardModelTracking?) {
        self.mainImage = mainImage
        self.mainTitle = mainTitle
        self.link = link
        self.tracking = tracking
    }
}

extension MLBusinessHybridCarouselViewMoreCardModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}
