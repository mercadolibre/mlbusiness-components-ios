//
//  MLBusinessFlexCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import UIKit

public protocol MLBusinessFlexCoverCarouselViewDelegate: class {
    func coverCarouselView(_: MLBusinessFlexCoverCarouselView, didSelect item: MLBusinessFlexCoverCarouselItemModel, at index: Int)
    func coverCarouselView(_: MLBusinessFlexCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessFlexCoverCarouselItemModel]?)
}

public class MLBusinessFlexCoverCarouselView: UIView {
    private var imageProvider: MLBusinessImageProvider?
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    private var model: MLBusinessFlexCoverCarouselModel?

    private var items: [MLBusinessFlexCoverCarouselItemModel] { return model?.items ?? [] }
    
    private var defaultCardWidth: CGFloat = 240
    private var defaultCardHeight: CGFloat = 160
    public weak var delegate: MLBusinessFlexCoverCarouselViewDelegate?
    
    private lazy var layout: MLBusinessCarouselSnappingLayout = {
        let layout = MLBusinessCarouselSnappingLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        return layout
    }()
    
    lazy var collectionViewDelegate: CarouselCollectionViewDelegate = {
        let delegate = CarouselCollectionViewDelegate()
        delegate.delegate = self
        return delegate
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.register(MLBusinessFlexCoverCarouselViewCell.self,
                                forCellWithReuseIdentifier: MLBusinessFlexCoverCarouselViewCell.reuseIdentifier)
        collectionView.dataSource = self
        
        return collectionView
    }()
        
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            collectionView.contentInset = contentInset
        }
    }
 
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
        collectionViewHeightConstraint?.constant = getMaxItemHeight()
        collectionView.reloadData()
    }
    
    func getMaxItemHeight() -> CGFloat {
        return (getItemCardWidth() * defaultCardHeight) / self.defaultCardWidth
    }
    
    private func getItemCardWidth() -> CGFloat {
        let cardWith = UIScreen.main.bounds.width - collectionViewDelegate.leftCellPeekWidth - collectionViewDelegate.rightCellPeekWidth - 16

        return (cardWith < defaultCardWidth) ? defaultCardWidth : cardWith
    }
            
    private func setupView() {
        collectionView.delegate = collectionViewDelegate
        collectionViewDelegate.edgeInset = 16
        collectionView.configureForPeekingDelegate()
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: getMaxItemHeight())
        collectionViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
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
        cell.animatesWhenPressed = true
        return cell
    }
}

extension MLBusinessFlexCoverCarouselView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getItemCardWidth(), height: getMaxItemHeight())
    }
}

extension MLBusinessFlexCoverCarouselView: CarouselCollectionViewDelegateDelegate {
    
    func carouselDelegateDidScrollToItem(_ carouselDelegate: CarouselCollectionViewDelegate) {
    }
    
    func carouselDelegate(_ carouselDelegate: CarouselCollectionViewDelegate, didSelectItemAt indexPath: IndexPath) {

        delegate?.coverCarouselView(self, didSelect:items[indexPath.item], at: indexPath.item)
    }
}

