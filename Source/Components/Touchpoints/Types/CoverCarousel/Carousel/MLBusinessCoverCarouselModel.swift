//
//  MLBusinessCoverCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//

import Foundation

public struct MLBusinessCoverCarouselModel: Codable {
    public let items: [MLBusinessCoverCarouselItemModel]
    public let alphaAnimation: Bool?
    public let scaleAnimation: Bool?
    public let pressAnimation: Bool?
    
    public init(items: [MLBusinessCoverCarouselItemModel],
                alphaAnimation: Bool?,
                scaleAnimation: Bool?,
                pressAnimation: Bool?) {
        self.items = items
        self.alphaAnimation = alphaAnimation
        self.scaleAnimation = scaleAnimation
        self.pressAnimation = pressAnimation
    }
}

extension MLBusinessCoverCarouselModel: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return items
    }
}
