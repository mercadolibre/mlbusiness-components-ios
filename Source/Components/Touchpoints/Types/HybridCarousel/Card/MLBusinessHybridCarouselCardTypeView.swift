//
//  MLBusinessHybridCarouselCardTypeView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 04/08/2020.
//

import Foundation

class MLBusinessHybridCarouselCardTypeView<Model>: UIView {
    
    var imageProvider: MLBusinessImageProvider = MLBusinessURLImageProvider()

    required init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with _: Model) {}

    func prepareForReuse() {}
}
