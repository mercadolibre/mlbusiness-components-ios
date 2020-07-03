//
//  MLBusinessCarouselContainerView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

public protocol MLBusinessCarouselContainerViewDelegate: class {
    func carouselContainerView(_: MLBusinessCarouselContainerView, didSelect item: MLBusinessCarouselItemModel, at index: Int)
    func carouselContainerView(_: MLBusinessCarouselContainerView, didFinishScrolling visibleItems: [MLBusinessCarouselItemModel]?)
}

public class MLBusinessCarouselContainerView: UIView {
    public weak var delegate: MLBusinessCarouselContainerViewDelegate?
    public var shouldHighlightItem = true
    public var leftMargin = CGFloat(0.0)
    static let minimumInteritemSpacing = CGFloat(12.0)

    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = MLBusinessCarouselContainerView.minimumInteritemSpacing
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MLBusinessCarouselContainerViewCell.self,
                                forCellWithReuseIdentifier: MLBusinessCarouselContainerViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()

    var items: [MLBusinessCarouselItemModel] = []
    var maxItemHeight = CGFloat(0)
    var collectionViewHeightConstraint: NSLayoutConstraint?
    
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            collectionView.contentInset = contentInset
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    private func setup() {
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 210)
        collectionViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func clear() {}

    public func update(with items: [MLBusinessCarouselItemModel]) {
        self.items = items
        setMaxItemHeight(with: items)
        collectionView.reloadData()
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
        collectionViewHeightConstraint?.constant = maxItemHeight
    }
    
    public func getVisibleItems() -> [MLBusinessCarouselItemModel]? {
            var visibleItems = [MLBusinessCarouselItemModel]()
            collectionView.indexPathsForVisibleItems.forEach { indexPath in
                visibleItems.append(items[indexPath.row])
            }
            return visibleItems.count > 0 ? visibleItems : nil
    }
}

extension MLBusinessCarouselContainerView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let visibleCollectionWidth = UIScreen.main.bounds.width - leftMargin
        let minimumWidth = CGFloat(116.0)
        let coeficient = CGFloat(2.8)
        let calculatedWidth = (visibleCollectionWidth / coeficient) - MLBusinessCarouselContainerView.minimumInteritemSpacing
        let width = visibleCollectionWidth / (minimumWidth + MLBusinessCarouselContainerView.minimumInteritemSpacing) > coeficient ? minimumWidth : max(minimumWidth, calculatedWidth)
        return CGSize(width: width , height: CGFloat(maxItemHeight))
    }
}

extension MLBusinessCarouselContainerView: UICollectionViewDataSource {
    public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: MLBusinessCarouselContainerViewCell.reuseIdentifier,
                                 for: indexPath) as? MLBusinessCarouselContainerViewCell else {
                                    return MLBusinessCarouselContainerViewCell() }
        let item = items[indexPath.row]
        cell.update(with: item)
        
        if let height = collectionViewHeightConstraint { cell.update(height: height.constant) }
        
        return cell
    }
}

extension MLBusinessCarouselContainerView: UICollectionViewDelegate {
    public func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.carouselContainerView(self, didSelect: items[indexPath.row], at: indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return shouldHighlightItem
    }
}

extension MLBusinessCarouselContainerView: UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }

    public func scrollViewDidEndDecelerating(_: UIScrollView) {
        delegate?.carouselContainerView(self, didFinishScrolling: getVisibleItems())
    }
}

extension MLBusinessCarouselContainerView: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return getVisibleItems()
    }
}
