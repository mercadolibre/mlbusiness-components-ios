//
//  MLBusinessCarouselSnappingLayout.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 05/11/2020.
//

import Foundation

class MLBusinessCarouselSnappingLayout: UICollectionViewFlowLayout {
    var scaleOffset: CGFloat = 200
    
    var layoutAttributeAnimators: [MLBusinessLayoutAttributeAnimator] = []
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let nextX: CGFloat

        if proposedContentOffset.x <= 0 || collectionView.contentOffset == proposedContentOffset {
            nextX = proposedContentOffset.x
        } else {
            nextX = collectionView.contentOffset.x + (velocity.x > 0 ? collectionView.bounds.size.width : -collectionView.bounds.size.width)
        }

        let targetRect = CGRect(x: nextX, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude

        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let collectionView = self.collectionView,
                let superAttributes = super.layoutAttributesForElements(in: rect) else {
                    return super.layoutAttributesForElements(in: rect)
            }

            let contentOffset = collectionView.contentOffset
            let size = collectionView.bounds.size

            let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
            let visibleCenterX = visibleRect.midX

            guard case let newAttributesArray as [UICollectionViewLayoutAttributes] = NSArray(array: superAttributes, copyItems: true) else {
                return nil
            }

        newAttributesArray.forEach { attributes in
            let distanceFromCenter = visibleCenterX - attributes.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), self.scaleOffset)
            
            layoutAttributeAnimators.forEach({ attributeAnimator in
                let scale = absDistanceFromCenter * (attributeAnimator.factor - 1) / self.scaleOffset + 1
                attributeAnimator.transform(attributes: attributes, with: scale)
            })
        }

            return newAttributesArray
        }

    override func shouldInvalidateLayout(forBoundsChange _: CGRect) -> Bool {
        return true
    }
}
