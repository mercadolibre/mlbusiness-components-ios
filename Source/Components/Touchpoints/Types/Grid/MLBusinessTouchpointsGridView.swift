//
//  MLBusinessTouchpointsGridView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

class MLBusinessTouchpointsGridView: MLBusinessTouchpointsBaseView {
    
    private var discountView = MLBusinessDiscountBoxView(MLBusinessTouchpointsGridModel())
    private var model: MLBusinessTouchpointsGridModel?
    private var touchpointTracker: MLBusinessTouchpointsPrintsTrackerProtocol?

    required init?(configuration: Codable?, touchpointsData: MLBusinessTouchpointsData) {
        super.init(configuration: configuration, touchpointsData: touchpointsData)
        setup()
        setupContraints()
        update(with: configuration, touchpointsData: touchpointsData)
    }

    private func setup() {
        prepareForAutolayout()
        addSubview(discountView)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            discountView.topAnchor.constraint(equalTo: topAnchor),
            discountView.leftAnchor.constraint(equalTo: leftAnchor),
            discountView.rightAnchor.constraint(equalTo: rightAnchor),
            discountView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func update(with configuration: Codable?, touchpointsData: MLBusinessTouchpointsData) {
        guard let model = configuration as? MLBusinessTouchpointsGridModel else { return }
        self.model = model
        touchpointTracker = MLBusinessTouchpointsPrintsTracker(with: touchpointsData)
        discountView.update(model)
    }
    
    override func addTapAction(_ action: ((Int, String?, String?) -> Void)?) {
        discountView.addTapAction(action)
    }
    
    override func trackVisiblePrints() {
        guard let trackables = getTrackables() else { return }
        
        touchpointTracker?.append(trackables: trackables)
        touchpointTracker?.trackPendingPrints()
    }
    
    override func resetTrackedPrints() {
        touchpointTracker?.resetTrackedPrints()
    }
    
    override func getTrackables() -> [Trackable]? {
        guard let model = model else { return nil }
        return model.getTrackables()
    }
    
}
