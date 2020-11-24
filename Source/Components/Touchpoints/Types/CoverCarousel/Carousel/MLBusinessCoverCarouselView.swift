//
//  MLBusinessCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 02/11/2020.
//

import UIKit

public protocol MLBusinessCoverCarouselViewDelegate: class {
    func coverCarouselView(_: MLBusinessCoverCarouselView, didSelect item: MLBusinessCoverCarouselItemModel, at index: Int)
    
    func coverCarouselView(_: MLBusinessCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessCoverCarouselItemModel]?)
}

public class MLBusinessCoverCarouselView: UIView {
    private var imageProvider: MLBusinessImageProvider?
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    private var model: MLBusinessCoverCarouselModel?

    private var items: [MLBusinessCoverCarouselItemModel] { return model?.items ?? [] }
    
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
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.register(MLBusinessCoverCarouselViewCell.self,
                                forCellWithReuseIdentifier: MLBusinessCoverCarouselViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            collectionView.contentInset = contentInset
        }
    }
    
    public weak var delegate: MLBusinessCoverCarouselViewDelegate?
    
    public var shouldHighlightItems = true
    
    public var scrollView: UIScrollView {
        return collectionView
    }
    
    public var visibleItems: [MLBusinessCoverCarouselItemModel]? {
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
    
    public func update(with model: MLBusinessCoverCarouselModel) {
        self.model = model
        
        setLayoutAnimators(from: model.carouselAnimation)
        collectionViewHeightConstraint?.constant = getMaxItemHeight(for: model)
        collectionView.reloadData()
    }
    
    func getMaxItemHeight(for model: MLBusinessCoverCarouselModel?) -> CGFloat {
        return model?.items.map({ getViewHeight(for: $0.content) }).max() ?? 0
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 96.0)
        collectionViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func getViewHeight(for model: MLBusinessCoverCarouselItemContentModel?) -> CGFloat {
        guard let model = model else { return 0 }
        
        return MLBusinessCoverCarouselItemView.height(for: model)
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

extension MLBusinessCoverCarouselView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MLBusinessCoverCarouselViewCell.reuseIdentifier,
                                                            for: indexPath) as? MLBusinessCoverCarouselViewCell,
              let content = items[indexPath.row].content else {
                                    return MLBusinessCoverCarouselViewCell()
        }
        
        cell.imageProvider = imageProvider
        cell.update(with: content)
        cell.animatesWhenPressed = model?.carouselAnimation?.pressAnimation ?? false
        
        return cell
    }
}

extension MLBusinessCoverCarouselView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: getMaxItemHeight(for: model))
    }
}

extension MLBusinessCoverCarouselView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.coverCarouselView(self, didSelect: items[indexPath.item], at: indexPath.item)
    }
    
    private func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return shouldHighlightItems
    }
}

extension MLBusinessCoverCarouselView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.coverCarouselView(self, didFinishScrolling: visibleItems)
    }
}
