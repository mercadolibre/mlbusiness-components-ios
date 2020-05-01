//
//  MLBusinessTouchpointsBaseView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import UIKit

protocol MLBusinessTouchpointsViewInitializable {
    init?(configuration: Codable?)
}

protocol MLBusinessTouchpointsViewUpdatable {
    func update(with: Codable?)
}

protocol MLBusinessTouchpointsViewProtocol: class {
    func trackTap(with selectedIndex: Int?, deeplink: String?, trackingId: String?)
    func trackPrints(prints: [Trackable]?)
}

protocol ComponentTrackable {
    func getTrackables() -> [Trackable]?
}

protocol Trackable {
    var trackingId: String? { get }
    var eventData: MLBusinessCodableDictionary? { get }
}

class MLBusinessTouchpointsBaseView: UIView & MLBusinessTouchpointsViewInitializable & MLBusinessTouchpointsViewUpdatable {
    weak var delegate: MLBusinessTouchpointsViewProtocol?

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    required init?(configuration: Codable?) {
        super.init(frame: .zero)
    }

    func update(with _: Codable?) {}
    
    func getVisibleItems() -> [Trackable]? { return nil }
}
