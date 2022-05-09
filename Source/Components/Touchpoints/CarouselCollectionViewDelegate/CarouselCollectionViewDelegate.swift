//
//  CarouselCollectionViewDelegate.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 05/05/2022.
//

import UIKit

@objc internal protocol CarouselCollectionViewDelegateDelegate: NSObjectProtocol {
    // Will be called when the current active index is changing
    @objc optional func carouselDelegate(_ carouselDelegate: CarouselCollectionViewDelegate, isChangingIndexTo index: Int, distance: CGFloat)
    // Will be called when the user taps on a cell at a specific index path
    @objc optional func carouselDelegate(_ carouselDelegate: CarouselCollectionViewDelegate, didSelectItemAt indexPath: IndexPath)
    @objc optional func carouselDelegateDidScrollToItem(_ carouselDelegate: CarouselCollectionViewDelegate)
}

internal class CarouselCollectionViewDelegate: NSObject {
    internal var edgeInset: CGFloat
    internal var cellSpacing: CGFloat
    internal var leftCellPeekWidth: CGFloat
    internal var rightCellPeekWidth: CGFloat
    internal let scrollThreshold: CGFloat
    internal let maximumItemsToScroll: Int
    internal let numberOfItemsToShow: Int
    internal let scrollDirection: UICollectionView.ScrollDirection
    internal var currentActiveIndex: Int = 0

    internal weak var delegate: CarouselCollectionViewDelegateDelegate?

    internal let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    fileprivate var currentScrollOffset = CGPoint.zero

    fileprivate lazy var itemLength: (UIView) -> CGFloat = {
        view in
        var frameWidth: CGFloat = self.scrollDirection.length(for: view)
        // Get the total remaining width for the
        let allItemsWidth = (frameWidth
            // If we have 2 items, there will be 1 spacing
            - (CGFloat(self.numberOfItemsToShow - 1) * self.cellSpacing)
            // and two edge insets
            - 2 * self.edgeInset
            // Additional edge insets
            - self.leftCellPeekWidth - self.rightCellPeekWidth)
        // Divide the remaining space by the number of items to get each item's width
        let finalWidth = allItemsWidth / CGFloat(self.numberOfItemsToShow)
        return max(0, finalWidth)
    }

    internal init(cellSpacing: CGFloat = 8, edgeInset: CGFloat = 16, leftCellPeekWidth: CGFloat = 0, rightCellPeekWidth: CGFloat = 0, scrollThreshold: CGFloat = 50, maximumItemsToScroll: Int = 1, numberOfItemsToShow: Int = 1, scrollDirection: UICollectionView.ScrollDirection = .horizontal) {
        self.cellSpacing = cellSpacing
        self.edgeInset = edgeInset
        self.leftCellPeekWidth = leftCellPeekWidth
        self.rightCellPeekWidth = rightCellPeekWidth
        self.scrollThreshold = scrollThreshold
        self.maximumItemsToScroll = maximumItemsToScroll
        self.numberOfItemsToShow = numberOfItemsToShow
        self.scrollDirection = scrollDirection
    }

    internal func scrollView(_ scrollView: UIScrollView, indexForItemAtContentOffset contentOffset: CGPoint) -> Int {
        let normalizedScrollingPosition = self.scrollView(scrollView, normalizedScrollingPositionForContentOffset: contentOffset)
        let index = Int(round(normalizedScrollingPosition))
        return index
    }

    internal func scrollView(_ scrollView: UIScrollView, normalizedScrollingPositionForContentOffset contentOffset: CGPoint) -> CGFloat {
        let width = itemLength(scrollView) + cellSpacing
        guard width > 0 else {
            return 0
        }
        let offset = scrollDirection.value(for: contentOffset)
        return offset / width
    }

    internal func scrollView(_ scrollView: UIScrollView, contentOffsetForItemAtIndex index: Int) -> CGFloat {
        return CGFloat(index) * (itemLength(scrollView) + cellSpacing)
    }

    fileprivate func getNumberOfItemsToScroll(scrollDistance: CGFloat, scrollWidth: CGFloat) -> Int {
        var coefficent = 0
        let safeScrollThreshold = max(scrollThreshold, 0.1)

        switch scrollDistance {
        case let x where abs(x / safeScrollThreshold) <= 1:
            coefficent = Int(scrollDistance / safeScrollThreshold)
        case let x where Int(abs(x / scrollWidth)) == 0:
            coefficent = max(-1, min(Int(scrollDistance / safeScrollThreshold), 1))
        default:
            coefficent = Int(scrollDistance / scrollWidth)
        }

        let finalCoefficent = max((-1) * maximumItemsToScroll, min(coefficent, maximumItemsToScroll))
        return finalCoefficent
    }
}

extension CarouselCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_: UIScrollView) {
        delegate?.carouselDelegateDidScrollToItem?(self)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Unexpected behavior happens if the scrollview's length is 0
        guard scrollDirection.length(for: scrollView) > 0 else {
            return
        }
        // Save the initial content offset that the collection view was going to scroll to
        let defaultTargetContentOffset = targetContentOffset.pointee
        // Get the scroll distance by subtracting the default target content offset from the current position that the user scrolled from
        let currentScrollDistance = scrollDirection.value(for: defaultTargetContentOffset) -
            scrollDirection.value(for: currentScrollOffset)
        // Get the number of items to scroll
        let numberOfItemsToScroll = getNumberOfItemsToScroll(scrollDistance: currentScrollDistance, scrollWidth: itemLength(scrollView))

        // Get the destination index. numberOfItemsToScroll can be a negative number so the destination would be a previous cell
        let destinationItemIndex = self.scrollView(scrollView, indexForItemAtContentOffset: currentScrollOffset) + numberOfItemsToScroll
        // Get the contentOffset from the destination index
        let destinationItemOffset = self.scrollView(scrollView, contentOffsetForItemAtIndex: destinationItemIndex)

        let newTargetContentOffset = scrollDirection.point(for: destinationItemOffset, defaultPoint: defaultTargetContentOffset)

        // Set the target content offset. After doing this, the collection view will automatically animate to the target content offset
        targetContentOffset.pointee = newTargetContentOffset

        if destinationItemIndex != currentActiveIndex {
            feedbackGenerator.impactOccurred()
        }

        currentActiveIndex = destinationItemIndex
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }

        let normalizedScrollingPosition = self.scrollView(scrollView, normalizedScrollingPositionForContentOffset: scrollView.contentOffset)

        let startIndex = Int(normalizedScrollingPosition)
        let startDistance = modf(normalizedScrollingPosition).1 * CGFloat(normalizedScrollingPosition >= 0 ? 1 : -1)
        let endIndex = startIndex + 1
        let endDistance = 1 - startDistance

        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        if 0 ..< numberOfItems ~= startIndex {
            delegate?.carouselDelegate?(self, isChangingIndexTo: startIndex, distance: startDistance)
        }

        if 0 ..< numberOfItems ~= endIndex, normalizedScrollingPosition >= 0 {
            delegate?.carouselDelegate?(self, isChangingIndexTo: endIndex, distance: endDistance)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentScrollOffset = scrollView.contentOffset
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return scrollDirection.size(for: itemLength(collectionView), defaultSize: collectionView.frame.size)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        let insets = edgeInset + leftCellPeekWidth
        return scrollDirection.edgeInsets(for: insets)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == currentActiveIndex {
            delegate?.carouselDelegate?(self, didSelectItemAt: indexPath)
        } else {
            currentActiveIndex = indexPath.row
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
