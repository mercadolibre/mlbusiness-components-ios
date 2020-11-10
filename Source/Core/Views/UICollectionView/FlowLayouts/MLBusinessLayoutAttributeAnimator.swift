//
//  MLBusinessLayoutAttributeAnimator.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 08/11/2020.
//

import Foundation

protocol MLBusinessLayoutAttributeAnimator {
    var factor: CGFloat { get }
    
    func transform(attributes: UICollectionViewLayoutAttributes, with scale: CGFloat)
}
