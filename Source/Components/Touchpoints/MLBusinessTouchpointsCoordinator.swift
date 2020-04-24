//
//  MLBusinessTouchpointsCoordinator.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

@objcMembers
open class MLBusinessTouchpointsCoordinator {
    private var touchpointsData: MLBusinessTouchpointsData
    private let registry = MLBusinessTouchpointsRegistry()
    private var touchpointView: MLBusinessTouchpointsView?
    private var touchpointViewType: MLBusinessTouchpointsView.Type?
    
    public init(_ data: MLBusinessTouchpointsData) {
        touchpointsData = data
    }
    
    public func getDiscountTouchpointsView() -> UIView? {
        touchpointViewType = registry.views(for: touchpointsData.getType())
        let touchpointMapper = registry.mapper(for: touchpointsData.getType())
        let codableContent = touchpointMapper?.map(dictionary: touchpointsData.getContent())
        touchpointView = touchpointViewType?.init(configuration: codableContent, trackingProvider: touchpointsData.getDiscountTracker?())
        return touchpointView
    }
    
    public func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {
        touchpointView?.addTapAction(action)
    }
    
    public func update(_ data: MLBusinessTouchpointsData) {
        touchpointsData = data
        
        if let viewType = registry.views(for: touchpointsData.getType()) {
            let touchpointMapper = registry.mapper(for: touchpointsData.getType())
            let codableContent = touchpointMapper?.map(dictionary: touchpointsData.getContent())
            
            if viewType != touchpointViewType {
                touchpointView = touchpointViewType?.init(configuration: codableContent, trackingProvider: touchpointsData.getDiscountTracker?())
            } else {
                touchpointView?.update(with: codableContent)
            }
        }
    }
}
