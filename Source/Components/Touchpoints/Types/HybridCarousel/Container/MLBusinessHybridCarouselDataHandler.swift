//
//  MLBusinessHybridCarouselDataHandler.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 28/07/2020.
//

import Foundation

protocol MLBusinessHybridCarouselDataHandlerDelegate: class {
    func carouselContainerView(didSelect item: MLBusinessHybridCarouselCardModel, at index: Int)
    func carouselContainerViewDidFinishScrolling()
}

class MLBusinessHybridCarouselDataHandler: NSObject {
    weak var delegate: MLBusinessHybridCarouselDataHandlerDelegate?
    var shouldHighlightItem = true
    var shouldCalculateItemWidth = true
    var leftMargin = CGFloat(0.0)
    var items: [MLBusinessHybridCarouselCardModel] = []
    var maxItemHeight = CGFloat(0)
    var collectionViewHeightConstraint: NSLayoutConstraint?
    var imageProvider: MLBusinessImageProvider?
    var cardTypeProvider: MLBusinessHybridCarouselCardTypeProvider?
    var cardTypeRegistry: MLBusinessHybridCarouselCardRegistry?
    
    func update(with items: [MLBusinessHybridCarouselCardModel]) {
        self.items = items
        setMaxItemHeight(with: items)
    }
    
    func getMaxItemHeight(with items: [MLBusinessHybridCarouselCardModel]) -> CGFloat {
        let registry = MLBusinessHybridCarouselCardRegistry()
        var hasTopImage = false, hasMiddleTitle = false, hasMiddleSubtitle = false, hasBottomTopLabel = false,
        hasBottomPrimaryLabel = false, hasBottomInfo = false
        let topSpaceHeight = 12.0, middleSpaceHeight = 12.0, topImageHeight = 72.0, middleTitleLabelHeight = 18.0, middleSubtitleLabelHeight = 15.0,
        bottomSectionHeightWithSubtitle = 49.0, bottomSectionHeightWithoutSubtitle = 53.0, spaceToBottom = 12.0
        var collectionViewHeight = 0.0
        
        for item in items {
            
            let hybridCarouselCardType = item.type
            let hybridCarouselCardContent = item.content
            
            if hybridCarouselCardType.lowercased() == MLBusinessHybridCarouselCardTypes.defaultType.lowercased() {
                
                let hybridCarouselCardMapper = registry.mapper(for: hybridCarouselCardType)
                let codableContent = hybridCarouselCardMapper?.map(dictionary: hybridCarouselCardContent)
                
                if let card = codableContent as? MLBusinessHybridCarouselCardDefaultModel {
                    if card.topImage != nil, !hasTopImage {
                        hasTopImage = true
                    }
                    if card.middleTitle != nil, !hasMiddleTitle {
                        hasMiddleTitle = true
                    }
                    if card.middleSubtitle != nil, !hasMiddleSubtitle {
                        hasMiddleSubtitle = true
                    }
                    if card.bottomTopLabel != nil, !hasBottomTopLabel {
                        hasBottomTopLabel = true
                    }
                    if card.bottomPrimaryLabel != nil, !hasBottomPrimaryLabel {
                        hasBottomPrimaryLabel = true
                    }
                    if card.bottomInfo != nil, !hasBottomInfo {
                        hasBottomInfo = true
                    }
                }
                
            }
        }
        
        collectionViewHeight += topSpaceHeight
        
        if hasTopImage {
            collectionViewHeight += topImageHeight
        }
        if hasMiddleTitle || hasMiddleSubtitle {
            collectionViewHeight += middleSpaceHeight
            collectionViewHeight += hasMiddleTitle ? middleTitleLabelHeight : 0
            collectionViewHeight += hasMiddleSubtitle ? middleSubtitleLabelHeight : 0
            
            if hasBottomTopLabel || hasBottomPrimaryLabel || hasBottomInfo {
                if hasMiddleSubtitle {
                    collectionViewHeight += bottomSectionHeightWithSubtitle
                } else {
                    collectionViewHeight += bottomSectionHeightWithoutSubtitle
                }
            }
        }
        collectionViewHeight += spaceToBottom
        
        return CGFloat(collectionViewHeight)
    }

    private func setMaxItemHeight(with items: [MLBusinessHybridCarouselCardModel]) {
        maxItemHeight = getMaxItemHeight(with: items)
    }
}

extension MLBusinessHybridCarouselDataHandler: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let defaultWidth = CGFloat(116.0)
        if shouldCalculateItemWidth {
            let visibleCollectionWidth = UIScreen.main.bounds.width - leftMargin
            let coeficient = CGFloat(2.8)
            let calculatedWidth = (visibleCollectionWidth / coeficient) - MLBusinessHybridCarouselContainerView.minimumInteritemSpacing
            let width = visibleCollectionWidth / (defaultWidth + MLBusinessHybridCarouselContainerView.minimumInteritemSpacing) > coeficient ? defaultWidth : max(defaultWidth, calculatedWidth)
            return CGSize(width: width , height: CGFloat(maxItemHeight))
        } else {
            return CGSize(width: defaultWidth , height: CGFloat(maxItemHeight))
        }
    }
}

extension MLBusinessHybridCarouselDataHandler: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        guard let cell = cardTypeProvider?.view(for: item.type, at: indexPath) else { return UICollectionViewCell() }
        cell.imageProvider = imageProvider
        cell.update(with: cardTypeRegistry?.mapper(for: item.type)?.map(dictionary: item.content))
        
        if let height = collectionViewHeightConstraint {
            cell.update(height: height.constant)
        }
        
        return cell
    }
}

extension MLBusinessHybridCarouselDataHandler: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.carouselContainerView(didSelect: items[indexPath.row], at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return shouldHighlightItem
    }
}

extension MLBusinessHybridCarouselDataHandler: UIScrollViewDelegate {
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
