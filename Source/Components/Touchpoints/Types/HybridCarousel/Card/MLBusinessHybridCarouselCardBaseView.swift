//
//  MLBusinessHybridCarouselCardBaseView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation
import UIKit

protocol MLBusinessHybridCarouselCardViewUpdatable {
    func update(with: Codable?)
}

class MLBusinessHybridCarouselCardBaseView: UIView & MLBusinessHybridCarouselCardViewUpdatable {
    
    var imageProvider: MLBusinessImageProvider = MLBusinessURLImageProvider()

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    required init() {
        super.init(frame: .zero)
    }

    func update(with _: Codable?) {}
}
