//
//  MLBusinessTouchpointsBaseView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import UIKit

protocol MLBusinessTouchpointsViewInitializable {
    init?(configuration: Codable?, touchpointsData: MLBusinessTouchpointsData)
}

protocol MLBusinessTouchpointsViewUpdatable {
    func update(with: Codable?, touchpointsData: MLBusinessTouchpointsData)
}

class MLBusinessTouchpointsBaseView: UIView & MLBusinessTouchpointsViewInitializable & MLBusinessTouchpointsViewUpdatable {
    weak var delegate: MLBusinessUserInteractionProtocol?
    let touchpointsData: MLBusinessTouchpointsData

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(configuration: Codable?, touchpointsData: MLBusinessTouchpointsData) {
        self.touchpointsData = touchpointsData
        super.init(frame: .zero)
    }

    func update(with _: Codable?, touchpointsData: MLBusinessTouchpointsData) {}
    
    func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {}
    
    func trackVisiblePrints() { }
    
    func resetTrackedPrints() { }
    
    func getTrackables() -> [Trackable]? {
        return nil
    }
}
