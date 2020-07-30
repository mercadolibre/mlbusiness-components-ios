//
//  MLBusinessHybridCarouselCardRegistry.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

protocol MLBusinessHybridCarouselCardRegistryProtocol {
    func mapper(for type: String) -> MLBusinessHybridCarouselCardMapperProtocol?
    func views(for type: String) -> MLBusinessHybridCarouselCardBaseView.Type?
}

class MLBusinessHybridCarouselCardRegistry: MLBusinessHybridCarouselCardRegistryProtocol {
    private var mappers: [String: MLBusinessHybridCarouselCardMapperProtocol] = [:]
    private var views: [String: MLBusinessHybridCarouselCardBaseView.Type] = [:]

    init() {
        register(type: "DEFAULT_CARD", mapper: MLBusinessHybridCarouselCardMapper<MLBusinessHybridCarouselCardDefaultModel>(), view: MLBusinessHybridCarouselCardDefaultView.self)
        register(type: "VIEW_MORE", mapper: MLBusinessHybridCarouselCardMapper<MLBusinessHybridCarouselViewMoreCardModel>(), view: MLBusinessHybridCarouselViewMoreCardView.self)
    }

    func register(type: String, mapper: MLBusinessHybridCarouselCardMapperProtocol, view: MLBusinessHybridCarouselCardBaseView.Type) {
        views[type.uppercased()] = view
        mappers[type.uppercased()] = mapper
    }

    func mapper(for type: String) -> MLBusinessHybridCarouselCardMapperProtocol? {
        return mappers[type.uppercased()]
    }

    func views(for type: String) -> MLBusinessHybridCarouselCardBaseView.Type? {
        return views[type.uppercased()]
    }
}
