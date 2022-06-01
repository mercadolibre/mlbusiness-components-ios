//
//  UICollectionView+PeekConfiguration.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 05/05/2022.
//

import UIKit

extension UICollectionView {
    func configureForPeekingDelegate(scrollDirection: UICollectionView.ScrollDirection = .horizontal) {
        decelerationRate = UIScrollView.DecelerationRate.fast
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = false
        // Keeping this to support older versions
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        layout.scrollDirection = scrollDirection
    }
}
