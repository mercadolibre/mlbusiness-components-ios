//
//  UIView+Autolayout.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/7/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit

internal extension UIView {
    func prepareForAutolayout(_ background: UIColor? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = background == nil ? .white : background
    }
}

internal extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
