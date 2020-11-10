//
//  MLBusinessScaleLayoutAttributeAnimator.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 08/11/2020.
//

import Foundation

class MLBusinessScaleLayoutAttributeAnimator: MLBusinessLayoutAttributeAnimator {
    let factor: CGFloat
    
    init(factor: CGFloat) {
        self.factor = factor
    }
    
    func transform(attributes: UICollectionViewLayoutAttributes, with value: CGFloat) {
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, value, value, 1)
    }
}
