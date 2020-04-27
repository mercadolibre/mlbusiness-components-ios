//
//  MLBusinessTouchpointsBaseView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import UIKit

protocol MLBusinessTouchpointsViewInitializable {
    init?(configuration: Codable?, trackingProvider: MLBusinessDiscountTrackerProtocol?)
}

protocol MLBusinessTouchpointsViewUpdatable {
    func update(with: Codable?, trackingProvider: MLBusinessDiscountTrackerProtocol?)
}

class MLBusinessTouchpointsBaseView: UIView & MLBusinessTouchpointsViewInitializable & MLBusinessTouchpointsViewUpdatable {
    weak var delegate: MLBusinessUserInteractionProtocol?

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(configuration: Codable?, trackingProvider: MLBusinessDiscountTrackerProtocol?) {
        super.init(frame: .zero)
    }

    func update(with _: Codable?, trackingProvider: MLBusinessDiscountTrackerProtocol? = nil) {}
    
    func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {}
}
