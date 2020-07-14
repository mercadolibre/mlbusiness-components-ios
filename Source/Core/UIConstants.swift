//
//  UIConstants.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 02/09/2019.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import Foundation
import UIKit

struct UI {
    struct Margin {
        ///Margin = 6
        static let XXXS_MARGIN: CGFloat = 6
        ///Margin = 10
        static let XXS_MARGIN: CGFloat = 10
        ///Margin = 12
        static let XS_MARGIN: CGFloat = 12
        ///Margin = 16
        static let S_MARGIN: CGFloat = 16
        ///Margin = 18
        static let M_MARGIN: CGFloat = 18
        ///Margin = 20
        static let XM_MARGIN: CGFloat = 20
        ///Margin = 24
        static let L_MARGIN: CGFloat = 24
    }

    struct FontSize {
        static let XXS_FONT: CGFloat = 12
        static let XS_FONT: CGFloat = 14
        static let S_FONT: CGFloat = 16
        static let M_FONT: CGFloat = 18
        static let ML_FONT: CGFloat = 20
        static let L_FONT: CGFloat = 22
    }

    struct Colors {
        static let placeHolderColor: UIColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        static let mainLabelColor: UIColor = UIColor(red:0, green:0, blue:0, alpha:0.8)
        static let downloadAppViewBackgroundColor: UIColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        static let dividingLineColor: UIColor = UIColor.black.withAlphaComponent(0.25)
    }
}
