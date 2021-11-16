//
//  String+Size.swift
//  MLBusinessComponents
//
//  Created by Gaston Daniel Gabriel Grippi on 16/11/2021.
//

import MLUI

internal extension String {
    func getFontSize() -> CGFloat {
        switch self.uppercased() {
        case "SMALL":
            return CGFloat(kMLFontsSizeXSmall)
        case "MEDIUM":
            return CGFloat(kMLFontsSizeSmall)
        default:
            return CGFloat(kMLFontsSizeXXSmall)
        }
    }
    
    func getImageSize() -> CGFloat {
        switch self.uppercased() {
        case "SMALL":
            return 14.0
        case "MEDIUM":
            return 16.0
        default:
            return 12.0
        }
    }
}
