//
//  MLBusinessTouchpointsGridView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

class MLBusinessTouchpointsGridView: MLBusinessTouchpointsView {
    
    private var discountView = MLBusinessDiscountBoxView(MLBusinessTouchpointsGridData(items: []))

    required init?(configuration: Codable?, trackingProvider: MLBusinessDiscountTrackerProtocol?) {
        super.init(configuration: configuration, trackingProvider: trackingProvider)
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
        discountView.update(MLBusinessTouchpointsGridData(title: model.getTitle(), subtitle: model.getSubtitle(), items: model.getItems(), trackingProvider: trackingProvider))
    }
    
    override func addTapAction(_ action: ((Int, String?, String?) -> Void)?) {
        discountView.addTapAction(action)
    }
}
