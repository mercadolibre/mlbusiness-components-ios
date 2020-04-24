//
//  MLBusinessTouchpointsGridMapper.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

protocol MLBusinessTouchpointsMapperProtocol {
    func map(dictionary: [String : Any]) -> Codable?
}

class MLBusinessTouchpointsGridMapper<Model: Codable>: MLBusinessTouchpointsMapperProtocol {
    func map(dictionary: [String : Any]) -> Codable? {
        let title = dictionary["title"] as? String
        let subtitle = dictionary["subtitle"] as? String
        if let items = dictionary["items"] as? [[String : Any]] {
            var gridItems: [MLBusinessTouchpointsGridItemModel] = []
            for item in items {
                if let gridItem = mapGridItem(with: item) {
                    gridItems.append(gridItem)
                }
            }
            return MLBusinessTouchpointsGridModel(title: title, subtitle: subtitle, items: gridItems)
        }
        return nil
    }
    
    func mapGridItem(with item: [String : Any]) -> MLBusinessTouchpointsGridItemModel? {
        guard let iconImageUrl = item["iconImageUrl"] as? String,
            let title = item["title"] as? String,
            let subtitle = item["subtitle"] as? String
            else { return nil }
        return MLBusinessTouchpointsGridItemModel(title: title,
                                                  subtitle: subtitle,
                                                  iconImageUrl: iconImageUrl,
                                                  deepLink: item["deepLink"] as? String,
                                                  trackId: item["trackingId"] as? String)
    }
}
