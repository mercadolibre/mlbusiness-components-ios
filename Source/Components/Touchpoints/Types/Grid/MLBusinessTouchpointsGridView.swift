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
        setupConstraints()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(discountView)
    }
    
    private func setupConstraints() {
        topConstraint = discountView.topAnchor.constraint(equalTo: topAnchor)
        topConstraint?.isActive = true
        leftConstraint = discountView.leftAnchor.constraint(equalTo: leftAnchor)
        leftConstraint?.isActive = true
        bottomConstraint = discountView.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint?.isActive = true
        rightConstraint = discountView.rightAnchor.constraint(equalTo: rightAnchor)
        rightConstraint?.isActive = true
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
    
    override func getTouchpointViewHeight(with data: Codable?, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
        guard let model = data as? MLBusinessTouchpointsGridModel else { return 0 }
        
        return discountView.itemHeight * (model.getItems().count > 3 ? 2 : 1) + topInset + bottomInset + 16.0
    }
}
