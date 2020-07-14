//
//  MLBusinessTouchpointsCarouselModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

struct MLBusinessTouchpointsCarouselModel: Codable, ComponentTrackable {
    private let title: String?
    private let subtitle: String?
    private let items: [MLBusinessCarouselItemModel]

    init(title: String?, subtitle: String?, items: [MLBusinessCarouselItemModel]) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }
    
    func getTrackables() -> [Trackable]? {
        return items
    }
    
    func getItems() -> [MLBusinessCarouselItemModel] {
        return items
    }
}
