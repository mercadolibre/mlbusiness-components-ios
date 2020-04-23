//
//  MLBusinessTouchpointsCoordinator.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

@objcMembers
open class MLBusinessTouchpointsCoordinator {
    private var response : MLBusinessTouchpointsResponse
    private let registry = MLBusinessTouchpointsRegistry()
    private var touchpointView: MLBusinessTouchpointsView?
    
    public init(response: MLBusinessTouchpointsResponse) {
        self.response = response
    }
    
    public func getView() -> UIView? {
        let touchpointViewType = registry.views(for: response.type)
        let touchpointMapper = registry.mapper(for: response.type)
        let codableContent = touchpointMapper?.map(dictionary: response.content)
        touchpointView = touchpointViewType?.init(configuration: codableContent)
        return touchpointView
    }
}
