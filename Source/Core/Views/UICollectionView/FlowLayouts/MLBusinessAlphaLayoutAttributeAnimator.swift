//
//  MLBusinessAlphaLayoutAttributeAnimator.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 08/11/2020.
//

import Foundation

class MLBusinessAlphaLayoutAttributeAnimator: MLBusinessLayoutAttributeAnimator {
    let factor: CGFloat
    
    init(factor: CGFloat) {
        self.factor = factor
    }
    
    func transform(attributes: UICollectionViewLayoutAttributes, with value: CGFloat) {
        attributes.alpha = value
    }
}
