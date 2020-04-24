//
//  MLBusinessTouchpointsRegistry.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

protocol MLBusinessTouchpointsRegistryProtocol {
    func mapper(for type: String) -> MLBusinessTouchpointsMapperProtocol?
    func views(for type: String) -> MLBusinessTouchpointsView.Type?
    func skeleton(for type: String) -> MLBusinessTouchpointsView.Type?
}

class MLBusinessTouchpointsRegistry: MLBusinessTouchpointsRegistryProtocol {
    private var mappers: [String: MLBusinessTouchpointsMapperProtocol] = [:]
    private var views: [String: MLBusinessTouchpointsView.Type] = [:]
    private var skeletons: [String: MLBusinessTouchpointsView.Type] = [:]

    init() {
        register(type: "GRID", mapper: MLBusinessTouchpointsMapper<MLBusinessTouchpointsGridModel>(), view: MLBusinessTouchpointsGridView.self, skeleton: nil)
    }

    func register(type: String, mapper: MLBusinessTouchpointsMapperProtocol, view: MLBusinessTouchpointsView.Type, skeleton: MLBusinessTouchpointsView.Type? = nil) {
        views[type] = view
        mappers[type] = mapper
        if let skeleton = skeleton {
            skeletons[type] = skeleton
        }
    }

    func mapper(for type: String) -> MLBusinessTouchpointsMapperProtocol? {
        return mappers[type]
    }

    func views(for type: String) -> MLBusinessTouchpointsView.Type? {
        return views[type]
    }

    func skeleton(for type: String) -> MLBusinessTouchpointsView.Type? {
        return skeletons[type]
    }
}
