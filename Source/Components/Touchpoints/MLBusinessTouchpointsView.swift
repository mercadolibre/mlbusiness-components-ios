//
//  MLBusinessTouchpointsView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import UIKit

protocol MLBusinessTouchpointsViewTrackingHandler: class {
    func track(id: String, data: [String: Any]?)
}

protocol MLBusinessTouchpointsViewInitializable {
    init?(configuration: Codable?)
}

protocol MLBusinessTouchpointsViewUpdatable {
    func update(with: Codable?)
}

class MLBusinessTouchpointsView: UIView & MLBusinessTouchpointsViewInitializable & MLBusinessTouchpointsViewUpdatable {
    weak var delegate: MLBusinessUserInteractionProtocol?
    weak var trackingHandler: MLBusinessTouchpointsViewTrackingHandler?

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(configuration _: Codable?) {
        super.init(frame: .zero)
    }

    func update(with _: Codable?) {}
}
