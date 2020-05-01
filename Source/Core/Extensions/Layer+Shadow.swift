//
//  Layer+Shadow.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import CoreGraphics
import UIKit

internal extension CALayer {
    func applyShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0,
                     y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0

        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

    func removeShadow() {
        shadowPath = nil
    }
}
