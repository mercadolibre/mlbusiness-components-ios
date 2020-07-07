//
//  MLBusinessTouchpointsCollectionViewDataHandler.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 06/07/2020.
//

import Foundation

protocol MLBusinessTouchpointsCollectionViewDataHandlerDelegate: class {
    func carouselContainerView(didSelect item: MLBusinessCarouselItemModel, at index: Int)
    func carouselContainerViewDidFinishScrolling()
}

class MLBusinessTouchpointsCollectionViewDataHandler: NSObject {
    weak var delegate: MLBusinessTouchpointsCollectionViewDataHandlerDelegate?
    var shouldHighlightItem = true
    var shouldCalculateItemWidth = true
    var leftMargin = CGFloat(0.0)
    var items: [MLBusinessCarouselItemModel] = []
    var maxItemHeight = CGFloat(0)
    var collectionViewHeightConstraint: NSLayoutConstraint?
    var imageProvider: MLBusinessImageProvider?
    
    func update(with items: [MLBusinessCarouselItemModel]) {
        self.items = items
        setMaxItemHeight(with: items)
    }
    
    func getMaxItemHeight(with items: [MLBusinessCarouselItemModel]) -> CGFloat {
        var hasTopLabel = false, hasMainLabel = false, hasTitle = false, hasSubtitle = false
        let spaceToMainLabel = 100.0, topLabelHeight = 14.0, mainLabelHeight = 28.0, titleHeight = 23.0, subtitleHeight = 15.0, spaceToBottom = 12.0
        for item in items {
            if item.topLabel != nil, !hasTopLabel {
                hasTopLabel = true
            }
            if item.mainLabel != nil, !hasMainLabel {
                hasMainLabel = true
            }
            if item.title != nil, !hasTitle {
                hasTitle = true
            }
            if item.subtitle != nil, !hasSubtitle {
                hasSubtitle = true
            }
        }
        let collectionViewHeight = spaceToMainLabel
            + (hasTopLabel ? topLabelHeight: 0.0)
            + (hasMainLabel ? mainLabelHeight : 0.0)
            + (hasTitle ? titleHeight : 0.0)
            + (hasSubtitle ? subtitleHeight : 0.0)
            + spaceToBottom
        
        return CGFloat(collectionViewHeight)
    }

    private func setMaxItemHeight(with items: [MLBusinessCarouselItemModel]) {
        maxItemHeight = getMaxItemHeight(with: items)
    }
}

extension MLBusinessTouchpointsCollectionViewDataHandler: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let defaultWidth = CGFloat(116.0)
        if shouldCalculateItemWidth {
            let visibleCollectionWidth = UIScreen.main.bounds.width - leftMargin
            let coeficient = CGFloat(2.8)
            let calculatedWidth = (visibleCollectionWidth / coeficient) - MLBusinessCarouselContainerView.minimumInteritemSpacing
            let width = visibleCollectionWidth / (defaultWidth + MLBusinessCarouselContainerView.minimumInteritemSpacing) > coeficient ? defaultWidth : max(defaultWidth, calculatedWidth)
            return CGSize(width: width , height: CGFloat(maxItemHeight))
        } else {
            return CGSize(width: defaultWidth , height: CGFloat(maxItemHeight))
        }
    }
}

extension MLBusinessTouchpointsCollectionViewDataHandler: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: MLBusinessTouchpointsCarouselContainerViewCell.reuseIdentifier,
                                 for: indexPath) as? MLBusinessTouchpointsCarouselContainerViewCell else {
                                    return MLBusinessTouchpointsCarouselContainerViewCell() }
        let item = items[indexPath.row]
        cell.imageProvider = imageProvider
        cell.update(with: item)
        
        if let height = collectionViewHeightConstraint {
            cell.update(height: height.constant)
        }
        
        return cell
    }
}

extension MLBusinessTouchpointsCollectionViewDataHandler: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.carouselContainerView(didSelect: items[indexPath.row], at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return shouldHighlightItem
    }
}

extension MLBusinessTouchpointsCollectionViewDataHandler: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }

    func scrollViewDidEndDecelerating(_: UIScrollView) {
        delegate?.carouselContainerViewDidFinishScrolling()
    }
}

extension MLBusinessCarouselContainerView: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return getVisibleItems()
    }
}
