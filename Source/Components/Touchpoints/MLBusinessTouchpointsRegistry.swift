//
//  MLBusinessTouchpointsRegistry.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

protocol MLBusinessTouchpointsRegistryProtocol {
    func mapper(for type: String) -> MLBusinessTouchpointsMapperProtocol?
    func views(for type: String) -> MLBusinessTouchpointsBaseView.Type?
}

class MLBusinessTouchpointsRegistry: MLBusinessTouchpointsRegistryProtocol {
    private var mappers: [String: MLBusinessTouchpointsMapperProtocol] = [:]
    private var views: [String: MLBusinessTouchpointsBaseView.Type] = [:]

    init() {
        register(type: "GRID", mapper: MLBusinessTouchpointsMapper<MLBusinessTouchpointsGridModel>(), view: MLBusinessTouchpointsGridView.self)
    }

    func register(type: String, mapper: MLBusinessTouchpointsMapperProtocol, view: MLBusinessTouchpointsBaseView.Type) {
        views[type] = view
        mappers[type] = mapper
    }

    func mapper(for type: String) -> MLBusinessTouchpointsMapperProtocol? {
        return mappers[type]
    }

    func views(for type: String) -> MLBusinessTouchpointsBaseView.Type? {
        return views[type]
    }
}
