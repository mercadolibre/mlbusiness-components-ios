//
//  MLBusinessHybridCarouselCardRegistry.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

protocol MLBusinessHybridCarouselCardViewRegistryProtocol {
    var types: [String] { get }
    func views(for type: String) -> MLBusinessHybridCarouselCardTypeCellProtocol.Type?
}
protocol MLBusinessHybridCarouselCardMapperRegistryProtocol {
    var types: [String] { get }
    func mapper(for type: String) -> MLBusinessMapperProtocol?
}

class MLBusinessHybridCarouselCardRegistry: MLBusinessHybridCarouselCardViewRegistryProtocol, MLBusinessHybridCarouselCardMapperRegistryProtocol {
    var types: [String] = []

    private var mappers: [String: MLBusinessMapperProtocol] = [:]
    private var views: [String: MLBusinessHybridCarouselCardTypeCellProtocol.Type] = [:]

    init() {
        register(type: MLBusinessHybridCarouselCardTypes.defaultType, mapper: MLBusinessMapper<MLBusinessHybridCarouselCardDefaultModel>(), view: MLBusinessHybridCarouselCardDefaultViewCell.self)
        register(type: MLBusinessHybridCarouselCardTypes.viewMoreType, mapper: MLBusinessMapper<MLBusinessHybridCarouselViewMoreCardModel>(), view: MLBusinessHybridCarouselViewMoreCardViewCell.self)
    }

    func register(type: String, mapper: MLBusinessMapperProtocol, view: MLBusinessHybridCarouselCardTypeCellProtocol.Type) {
        views[type.uppercased()] = view
        mappers[type.uppercased()] = mapper
        types.append(type.uppercased())
    }

    func mapper(for type: String) -> MLBusinessMapperProtocol? {
        return mappers[type.uppercased()]
    }

    func views(for type: String) -> MLBusinessHybridCarouselCardTypeCellProtocol.Type? {
        return views[type.uppercased()]
    }
}
