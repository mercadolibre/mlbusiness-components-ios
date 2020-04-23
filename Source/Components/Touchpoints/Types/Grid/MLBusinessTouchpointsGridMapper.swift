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
        if let items = dictionary["items"] as? [MLBusinessTouchpointsGridItemModel] {
            return MLBusinessTouchpointsGridModel(items: items)
        }
        return nil
    }
}
