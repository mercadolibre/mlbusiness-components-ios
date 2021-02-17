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
    var topConstraint, leftConstraint, bottomConstraint, rightConstraint: NSLayoutConstraint?
    var canOpenMercadoPagoApp: Bool?
    let defaultComponentHeight = CGFloat(272)

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    required init?(configuration: Codable?) {
        super.init(frame: .zero)
    }

    func update(with _: Codable?) {}
    
    func setAdditionalEdgeInsets(with insets: [String : Any]?) {
        guard let additionalEdgeInsets = insets else { return }
        
        topConstraint?.constant = CGFloat(additionalEdgeInsets["top"] as? NSNumber ?? 0)
        leftConstraint?.constant = CGFloat(additionalEdgeInsets["left"] as? NSNumber ?? 0)
        bottomConstraint?.constant = -CGFloat(additionalEdgeInsets["bottom"] as? NSNumber ?? 0)
        rightConstraint?.constant = -CGFloat(additionalEdgeInsets["right"] as? NSNumber ?? 0)
    }
    
    func getVisibleItems() -> [Trackable]? { return nil }
    
    func getTouchpointViewHeight(with data: Codable?, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
        return defaultComponentHeight
    }
}
