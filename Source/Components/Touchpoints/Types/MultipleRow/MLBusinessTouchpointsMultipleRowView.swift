//
//  MLBusinessTouchpointsMultipleRowView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 12/08/2020.
//

import Foundation

class MLBusinessTouchpointsMultipleRowView: MLBusinessTouchpointsBaseView {
    
    private var multipleRowView = MLBusinessMultipleRowView()
    private var model: MLBusinessTouchpointsMultipleRowModel?
    private var action: ((Int, String?, String?) -> Void)?

    required init?(configuration: Codable?) {
        super.init(configuration: configuration)
        setup()
        setupConstraints()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(multipleRowView)
    }
    
    private func setupConstraints() {
        topConstraint = multipleRowView.topAnchor.constraint(equalTo: topAnchor)
        topConstraint?.isActive = true
        leftConstraint = multipleRowView.leftAnchor.constraint(equalTo: leftAnchor)
        leftConstraint?.isActive = true
        bottomConstraint = multipleRowView.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint?.isActive = true
        rightConstraint = multipleRowView.rightAnchor.constraint(equalTo: rightAnchor)
        rightConstraint?.isActive = true
    }
    
    override func update(with configuration: Codable?) {
        guard let model = configuration as? MLBusinessTouchpointsMultipleRowModel else { return }
        self.model = model
        multipleRowView.update(with: model.getItems())
    }
    
    override func getVisibleItems() -> [Trackable]? {
        return model?.getTrackables()
    }
    
    override func getTouchpointViewHeight(with data: Codable?, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
        guard let model = data as? MLBusinessTouchpointsGridModel else { return 0 }
        let defaultHeight = CGFloat(96.0)
        return defaultHeight * CGFloat(model.getItems().count) + topInset + bottomInset
    }
}
