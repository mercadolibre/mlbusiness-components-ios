//
//  MLBusinessHybridCarouselCardRegistry.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

protocol MLBusinessHybridCarouselCardRegistryProtocol {
    func mapper(for type: String) -> MLBusinessMapperProtocol?
    func views(for type: String) -> MLBusinessHybridCarouselCardBaseView.Type?
}

class MLBusinessHybridCarouselCardRegistry: MLBusinessHybridCarouselCardRegistryProtocol {
    private var mappers: [String: MLBusinessMapperProtocol] = [:]
    private var views: [String: MLBusinessHybridCarouselCardBaseView.Type] = [:]

    init() {
        register(type: "DEFAULT", mapper: MLBusinessMapper<MLBusinessHybridCarouselCardDefaultModel>(), view: MLBusinessHybridCarouselCardDefaultView.self)
        register(type: "VIEW_MORE", mapper: MLBusinessMapper<MLBusinessHybridCarouselViewMoreCardModel>(), view: MLBusinessHybridCarouselViewMoreCardView.self)
    }

    func register(type: String, mapper: MLBusinessMapperProtocol, view: MLBusinessHybridCarouselCardBaseView.Type) {
        views[type.uppercased()] = view
        mappers[type.uppercased()] = mapper
    }

    func mapper(for type: String) -> MLBusinessMapperProtocol? {
        return mappers[type.uppercased()]
    }

    func views(for type: String) -> MLBusinessHybridCarouselCardBaseView.Type? {
        return views[type.uppercased()]
    }
}
