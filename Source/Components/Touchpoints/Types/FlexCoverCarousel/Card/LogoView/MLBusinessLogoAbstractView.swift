//
//  MLBusinessLogoAbstractView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 24/06/2022.
//

import Foundation

class MlBusinessLogoAbstractView: UIView {
    let data: FlexCoverCarouselLogo
        
    init(with data: FlexCoverCarouselLogo, imageProvider: MLBusinessImageProvider = MLBusinessURLImageProvider()) {
        self.data = data
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
