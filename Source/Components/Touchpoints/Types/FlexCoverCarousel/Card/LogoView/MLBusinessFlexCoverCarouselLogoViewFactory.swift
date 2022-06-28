//
//  MLBusinessFlexCoverCarouselLogoViewFactory.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 23/06/2022.
//

import Foundation

struct MLBusinessFlexCoverCarouselLogoViewFactory {
    static func provide(logo: FlexCoverCarouselLogo) -> MlBusinessLogoAbstractView {
        switch logo.type {
        case .image:
            return MLBusinessLogoImageView(with: logo)
        case .text:
            return MLBusinessLogoTextView(with: logo)
        }
    }

}
