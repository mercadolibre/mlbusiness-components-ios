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
    private var action: ((Int, String?, String?) -> Void)?

    required init?(configuration: Codable?) {
        super.init(configuration: configuration)
        setup()
        setupContraints()
        update(with: configuration)
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
    
    override func update(with configuration: Codable?) {
        guard let model = configuration as? MLBusinessTouchpointsGridModel else { return }
        self.model = model
        discountView.update(model)
        discountView.addTapAction { (selectedIndex, deeplink, trackingId) in
            self.delegate?.trackTap(with: selectedIndex, deeplink: deeplink, trackingId: trackingId)
        }
    }
    
    override func getVisibleItems() -> [Trackable]? {
        return model?.getTrackables()
    }
}
