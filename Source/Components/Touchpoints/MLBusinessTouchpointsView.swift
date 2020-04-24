//
//  MLBusinessTouchpointsView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import UIKit

protocol MLBusinessTouchpointsViewInitializable {
    init?(configuration: Codable?, trackingProvider: MLBusinessDiscountTrackerProtocol?)
}

protocol MLBusinessTouchpointsViewUpdatable {
    func update(with: Codable?)
}

class MLBusinessTouchpointsView: UIView & MLBusinessTouchpointsViewInitializable & MLBusinessTouchpointsViewUpdatable {
    weak var delegate: MLBusinessUserInteractionProtocol?
    let trackingProvider: MLBusinessDiscountTrackerProtocol?

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(configuration _: Codable?, trackingProvider: MLBusinessDiscountTrackerProtocol? = nil) {
        self.trackingProvider = trackingProvider
        super.init(frame: .zero)
    }

    func update(with _: Codable?) {}
    
    func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {}
}
