//
//  MLBusinessFlexCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import UIKit
import MLUI

public protocol MLBusinessFlexCoverCarouselViewDelegate: class {
    func coverCarouselView(_: MLBusinessFlexCoverCarouselView, didSelect item: MLBusinessFlexCoverCarouselItemModel, at index: Int)
    
    func coverCarouselView(_: MLBusinessFlexCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessFlexCoverCarouselItemModel]?)
}

public class MLBusinessFlexCoverCarouselView: UIView {
    private var imageProvider: MLBusinessImageProvider?
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    private var model: MLBusinessFlexCoverCarouselModel?

    private var items: [MLBusinessFlexCoverCarouselItemModel] { return model?.items ?? [] }
    
    private lazy var layout: MLBusinessCarouselSnappingLayout = {
        let layout = MLBusinessCarouselSnappingLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: 32, bottom: 0, right: 32)
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.register(MLBusinessFlexCoverCarouselViewCell.self,
                                forCellWithReuseIdentifier: MLBusinessFlexCoverCarouselViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
        
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            collectionView.contentInset = contentInset
        }
    }
    
    var cardWidth: CGFloat = UIScreen.main.bounds.width - 32
    
    public weak var delegate: MLBusinessFlexCoverCarouselViewDelegate?
    
    public var shouldHighlightItems = true
    
    public var scrollView: UIScrollView {
        return collectionView
    }
    
    public var visibleItems: [MLBusinessFlexCoverCarouselItemModel]? {
        return collectionView.indexPathsForVisibleItems.compactMap({ items[$0.item] })
    }
    
    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider
        
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: MLBusinessFlexCoverCarouselModel) {
        self.model = model
        
        //setLayoutAnimators(from: model.carouselAnimation)
        collectionViewHeightConstraint?.constant = getMaxItemHeight(for: model)
        collectionView.reloadData()
    }
    
    func getMaxItemHeight(for model: MLBusinessFlexCoverCarouselModel?) -> CGFloat {
        return 160
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 160)
        collectionViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func getViewHeight(for model: MLBusinessFlexCoverCarouselItemModel?) -> CGFloat {
        guard let model = model else { return 0 }
        
        return 107 + 83
    }
    
    private func setLayoutAnimators(from model: MLBusinessCoverCarouselAnimation?) {
        let shouldAnimateAlpha = model?.alphaAnimation ?? false
        let shouldAnimateScale = model?.scaleAnimation ?? false

        
        var animators: [MLBusinessLayoutAttributeAnimator] = []
        
        if shouldAnimateAlpha {
            animators.append(MLBusinessAlphaLayoutAttributeAnimator(factor: 0.7))
        }
        
        if shouldAnimateScale {
            animators.append(MLBusinessScaleLayoutAttributeAnimator(factor: 0.95))
            layout.minimumLineSpacing = 0.5
        }
        
        layout.layoutAttributeAnimators = animators
    }
}

extension MLBusinessFlexCoverCarouselView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let content = items[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MLBusinessFlexCoverCarouselViewCell.reuseIdentifier,
                                                            for: indexPath) as? MLBusinessFlexCoverCarouselViewCell
              else {
                                    return MLBusinessFlexCoverCarouselViewCell()
        }
        
        cell.imageProvider = imageProvider
        cell.update(with: content)
        //cell.animatesWhenPressed = model?.carouselAnimation?.pressAnimation ?? false
        
        return cell
    }
}

extension MLBusinessFlexCoverCarouselView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cardWidth, height: getMaxItemHeight(for: model))
    }
}

extension MLBusinessFlexCoverCarouselView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.coverCarouselView(self, didSelect: items[indexPath.item], at: indexPath.item)
    }
    
    private func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return shouldHighlightItems
    }
}

extension MLBusinessFlexCoverCarouselView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.coverCarouselView(self, didFinishScrolling: visibleItems)
    }
}

