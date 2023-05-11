//
//  MLBusinessDynamicCoverCarouselConstants.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 04/11/2022.
//

import Foundation

enum MLBusinessDynamicCoverCarouselConstants {
    enum Card {
        static let peakWidthLandscape = Float(0.20)
        static let landscapeInset = CGFloat(16)
        static let itemMaxHeightLandscape = Float(156)
        static let peakWidthPortait = Float(0.35)
        static let portaitInset = CGFloat(16)
        static let itemMaxHeightPortait = Float(200)
        
        /// LandscapeExtended
        static let itemMaxHeightLandscapeExtended = Float(220)
        static let insetLandscapeExtended = CGFloat(16)
        static let peakWidthLandscapeExtended = Float(0.20)
        
        /// LandscapeShortened
        static let itemMaxHeightLandscapeShortened = Float(150)
        static let insetLandscapeShortened = CGFloat(16)
        static let peakWidthLandscapeShortened = Float(0.20)
    }
    
    enum Item {
        static let backgroundColor = String("#EEEEEE")
        static let footerBackgroundColor = String("#000000")
    }
}
