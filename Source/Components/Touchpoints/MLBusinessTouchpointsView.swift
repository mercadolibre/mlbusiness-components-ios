//
//  MLBusinessTouchpointsView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

@objcMembers
open class MLBusinessTouchpointsView: UIView {
    private let registry = MLBusinessTouchpointsRegistry()
    private var touchpointView: MLBusinessTouchpointsBaseView?
    private var touchpointViewType: MLBusinessTouchpointsBaseView.Type?
    
    public init(_ data: MLBusinessTouchpointsData, trackingProvider: MLBusinessDiscountTrackerProtocol? = nil) {
        super.init(frame: .zero)
        prepareForAutolayout()
        update(with: data, trackingProvider: trackingProvider)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {
        touchpointView?.addTapAction(action)
    }
    
    public func update(with data: MLBusinessTouchpointsData, trackingProvider: MLBusinessDiscountTrackerProtocol? = nil) {
        let touchpointResponse = data.getResponse()
        guard let touchpointType = touchpointResponse["type"] as? String,
            let touchpointContent = touchpointResponse["content"] as? [String : Any]
            else { return }
        
        if let viewType = registry.views(for: touchpointType) {
            let touchpointMapper = registry.mapper(for: touchpointType)
            let codableContent = touchpointMapper?.map(dictionary: MLBusinessCodableDictionary(value: touchpointContent))
            
            if viewType != touchpointViewType {
                touchpointViewType = viewType
                touchpointView = viewType.init(configuration: codableContent, trackingProvider: trackingProvider)
                subviews.forEach{ $0.removeFromSuperview() }
                setupTouchpointView()
            } else {
                touchpointView?.update(with: codableContent, trackingProvider: trackingProvider)
            }
        }
    }
    
    private func setupTouchpointView() {
        guard let touchpointView = touchpointView else { return }
        
        touchpointView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(touchpointView)
        
        NSLayoutConstraint.activate([
            touchpointView.topAnchor.constraint(equalTo: topAnchor),
            touchpointView.leftAnchor.constraint(equalTo: leftAnchor),
            touchpointView.rightAnchor.constraint(equalTo: rightAnchor),
            touchpointView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
