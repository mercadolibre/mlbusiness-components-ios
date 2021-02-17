//
//  MLBusinessTouchpointsView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

@objc public protocol MLBusinessTouchpointsUserInteractionHandler: NSObjectProtocol {
    func didTap(with selectedIndex: Int, deeplink: String, trackingId: String)
}

@objcMembers
open class MLBusinessTouchpointsView: UIView {
    private let registry = MLBusinessTouchpointsRegistry()
    private var touchpointView: MLBusinessTouchpointsBaseView?
    private var touchpointsData: MLBusinessTouchpointsData?
    private var touchpointTracker: MLBusinessTouchpointsTrackerProtocol?
    private var componentTrackable: ComponentTrackable?
    public weak var delegate: MLBusinessTouchpointsUserInteractionHandler?
    private var trackingProvider: MLBusinessDiscountTrackerProtocol?
    private var canOpenMercadoPagoApp: Bool?
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with data: MLBusinessTouchpointsData) {
        let touchpointType = data.getTouchpointType()
        let touchpointContent = data.getTouchpointContent()
        
        if let viewType = registry.views(for: touchpointType) {
            let touchpointMapper = registry.mapper(for: touchpointType)
            let codableContent = touchpointMapper?.map(dictionary: MLBusinessCodableDictionary(value: touchpointContent))
            
            trackingProvider?.setTouchpointId?(with: data.getTouchpointId())
            touchpointTracker = MLBusinessTouchpointsTracker(with: data, trackingProvider:trackingProvider)
            componentTrackable = codableContent as? ComponentTrackable
            
            if data.getTouchpointType() != touchpointsData?.getTouchpointType() || touchpointView == nil{
                touchpointsData = data
                touchpointView = viewType.init(configuration: codableContent)
                setupTouchpointView()
            }
            
            touchpointView?.setAdditionalEdgeInsets(with: touchpointsData?.getAdditionalEdgeInsets?())
            touchpointView?.update(with: codableContent)
            touchpointView?.canOpenMercadoPagoApp = canOpenMercadoPagoApp
            touchpointView?.delegate = self
            trackShow()
        }
    }
    
    public func getTouchpointViewHeight(with data: MLBusinessTouchpointsData) -> CGFloat {
        let touchpointType = data.getTouchpointType()
        let touchpointMapper = registry.mapper(for: touchpointType)
        let codableContent = touchpointMapper?.map(dictionary: MLBusinessCodableDictionary(value: data.getTouchpointContent()))
        let touchpointView = registry.views(for: touchpointType)?.init(configuration: codableContent)
        let additionalEdgeInsets = data.getAdditionalEdgeInsets?()
        let topInset = CGFloat(additionalEdgeInsets?["top"] as? NSNumber ?? 0)
        let bottomInset = CGFloat(additionalEdgeInsets?["bottom"] as? NSNumber ?? 0)
        return touchpointView?.getTouchpointViewHeight(with: codableContent, topInset: topInset, bottomInset: bottomInset) ?? 0
    }
    
    public func setTouchpointsTracker(with trackingProvider: MLBusinessDiscountTrackerProtocol) {
        self.trackingProvider = trackingProvider
    }
    
    public func trackVisiblePrints() {
        guard let visibleItems = getVisibleItems() else { return }
        touchpointTracker?.trackPrints(items: visibleItems)
    }
    
    public func resetTrackedPrints() {
        touchpointTracker?.resetTrackedPrints()
    }
    
    public func setCanOpenMercadoPagoApp(_ value: Bool) {
        canOpenMercadoPagoApp = value
    }
    
    private func getVisibleItems() -> [Trackable]? {
        return touchpointView?.getVisibleItems()
    }
    
    private func trackShow() {
        guard let items = componentTrackable?.getTrackables() else { return }
        touchpointTracker?.trackShow(items: items)
    }
    
    private func setupTouchpointView() {
        guard let touchpointView = touchpointView else { return }
        subviews.forEach{ $0.removeFromSuperview() }
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

extension MLBusinessTouchpointsView: MLBusinessTouchpointsViewProtocol {
    func trackTap(with selectedIndex: Int?, deeplink: String?, trackingId: String?) {
        if let selectedIndex = selectedIndex, let deeplink = deeplink, let trackingId = trackingId  {
            delegate?.didTap(with: selectedIndex, deeplink: deeplink, trackingId: trackingId)
            guard let items = componentTrackable?.getTrackables() else { return }
            items.forEach { item in
                if item.trackingId == trackingId {
                    touchpointTracker?.trackTap(item: item)
                    return
                }
            }
        }
    }
    
    func trackPrints(prints: [Trackable]?) {
        guard let prints = prints else { return }
        touchpointTracker?.trackPrints(items: prints)
    }
}
