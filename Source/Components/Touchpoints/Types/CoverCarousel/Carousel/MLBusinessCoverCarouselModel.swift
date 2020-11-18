//
//  MLBusinessCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselModel: Codable {
    public let items: [MLBusinessCoverCarouselItemModel]
    public let carouselAnimation: MLBusinessCoverCarouselAnimation?
    
    public init(items: [MLBusinessCoverCarouselItemModel], carouselAnimation: MLBusinessCoverCarouselAnimation?) {
        self.items = items
        self.carouselAnimation = carouselAnimation
    }
}

extension MLBusinessCoverCarouselModel: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return items
    }
}

public struct MLBusinessCoverCarouselAnimation: Codable {
    public let alphaAnimation: Bool?
    public let scaleAnimation: Bool?
    public let pressAnimation: Bool?
    
    public init(alphaAnimation: Bool?,
                scaleAnimation: Bool?,
                pressAnimation: Bool?) {
        self.alphaAnimation = alphaAnimation
        self.scaleAnimation = scaleAnimation
        self.pressAnimation = pressAnimation
    }
}
