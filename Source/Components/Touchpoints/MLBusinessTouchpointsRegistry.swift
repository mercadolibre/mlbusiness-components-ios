//
//  MLBusinessTouchpointsRegistry.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

protocol MLBusinessTouchpointsRegistryProtocol {
    func mapper(for type: String) -> MLBusinessMapperProtocol?
    func views(for type: String) -> MLBusinessTouchpointsBaseView.Type?
}

class MLBusinessTouchpointsRegistry: MLBusinessTouchpointsRegistryProtocol {
    private var mappers: [String: MLBusinessMapperProtocol] = [:]
    private var views: [String: MLBusinessTouchpointsBaseView.Type] = [:]

    init() {
        register(type: "GRID", mapper: MLBusinessMapper<MLBusinessTouchpointsGridModel>(), view: MLBusinessTouchpointsGridView.self)
        register(type: "CAROUSEL", mapper: MLBusinessMapper<MLBusinessTouchpointsCarouselModel>(), view: MLBusinessTouchpointsCarouselView.self)
        register(type: "HYBRID_CAROUSEL", mapper: MLBusinessMapper<MLBusinessHybridCarouselModel>(), view: MLBusinessHybridCarouselView.self)
        register(type: "MULTIPLE_ROW", mapper: MLBusinessMapper<MLBusinessTouchpointsMultipleRowModel>(), view: MLBusinessTouchpointsMultipleRowView.self)
    }

    func register(type: String, mapper: MLBusinessMapperProtocol, view: MLBusinessTouchpointsBaseView.Type) {
        views[type] = view
        mappers[type] = mapper
    }

    func mapper(for type: String) -> MLBusinessMapperProtocol? {
        return mappers[type]
    }

    func views(for type: String) -> MLBusinessTouchpointsBaseView.Type? {
        return views[type]
    }
}
