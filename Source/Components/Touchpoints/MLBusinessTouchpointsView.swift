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
    private var touchpointViewType: String?
    private var touchpointsData: MLBusinessTouchpointsData
    
    public init(_ data: MLBusinessTouchpointsData) {
        touchpointsData = data
        super.init(frame: .zero)
        prepareForAutolayout()
        update(with: data)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {
        touchpointView?.addTapAction(action)
    }
    
    public func update(with data: MLBusinessTouchpointsData) {
        touchpointsData = data
        let touchpointResponse = data.getResponse()
        let touchpointContent = touchpointResponse.getTouchpointContent()
        let touchpointViewType = touchpointResponse.getTouchpointType()

        if let viewType = registry.views(for: touchpointViewType) {
            let touchpointMapper = registry.mapper(for: touchpointViewType)
            let codableContent = touchpointMapper?.map(dictionary: MLBusinessCodableDictionary(value: touchpointContent))
            
            if self.touchpointViewType != touchpointViewType {
                self.touchpointViewType = touchpointViewType
                touchpointView = viewType.init(configuration: codableContent, touchpointsData: data)
                subviews.forEach{ $0.removeFromSuperview() }
                setupTouchpointView()
            } else {
                touchpointView?.update(with: codableContent, touchpointsData: data)
            }
        }
    }
    
    public func trackVisiblePrints() {
        touchpointView?.trackVisiblePrints()
    }
    
    public func resetTrackedPrints() {
        touchpointView?.resetTrackedPrints()
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
