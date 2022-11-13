//
//  MLBusinessDynamicCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public protocol MLBusinessDynamicCoverCarouselViewDelegate: class {
    func dynamicCoverCarouselView(_: MLBusinessDynamicCoverCarouselView, didSelect item: MLBusinessDynamicCoverCarouselItemModel, at index: Int)
    func dynamicCoverCarouselView(_: MLBusinessDynamicCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessDynamicCoverCarouselItemModel]?)
}

public class MLBusinessDynamicCoverCarouselView: UIView {
    private var imageProvider: MLBusinessImageProvider?
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    private var model: MLBusinessDynamicCoverCarouselModel?
    private var items: [MLBusinessDynamicCoverCarouselItemModel] { return model?.items ?? [] }
    private var defaultCardWidth: CGFloat = 240
    private var maxItemHeight: CGFloat = 156
    public weak var delegate: MLBusinessDynamicCoverCarouselViewDelegate?

    private lazy var collectionViewHelper: CarouselCollectionViewHelper = {
        let helper = CarouselCollectionViewHelper()
        helper.delegate = self
        return helper
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.register(MLBusinessDynamicCoverCarouselViewCell.self, forCellWithReuseIdentifier: MLBusinessDynamicCoverCarouselViewCell.reuseIdentifier)
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
    
    public var visibleItems: [MLBusinessDynamicCoverCarouselItemModel]? {
        return collectionView.indexPathsForVisibleItems.compactMap({ items[$0.item] })
    }
    
    public init(imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider

        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        collectionView.delegate = collectionViewHelper
        collectionView.configureForPeekingDelegate()
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func update(with model: MLBusinessDynamicCoverCarouselModel?) {
        self.model = model
        configureCard(cardType: model?.type ?? "landscape")
        collectionView.reloadData()
    }
    
    private func getMaxItemHeight() -> CGFloat {
        return maxItemHeight
    }
    
    private func getItemCardWidth() -> CGFloat {
        let cardWidth = UIScreen.main.bounds.width - collectionViewHelper.leftCellPeekWidth - collectionViewHelper.rightCellPeekWidth - 16

        return (cardWidth < defaultCardWidth) ? defaultCardWidth : cardWidth
    }
    
    private func configureCard(cardType: String){
        switch cardType {
        case "landscape":
            setupCollectionView(peekWidth: getPeekWidth(offset: MLBusinessDynamicCoverCarouselConstants.card.peakWidthLandscape),
                                maxHeightCard: MLBusinessDynamicCoverCarouselConstants.card.itemMaxHeightLandscape,
                                edgeInset: MLBusinessDynamicCoverCarouselConstants.card.landscapeInset)
        case "portait":
            setupCollectionView(peekWidth: getPeekWidth(offset: MLBusinessDynamicCoverCarouselConstants.card.peakWidthPortait),
                                maxHeightCard: MLBusinessDynamicCoverCarouselConstants.card.itemMaxHeightPortait,
                                edgeInset: MLBusinessDynamicCoverCarouselConstants.card.portaitInset)
        default:
            setupCollectionView(peekWidth: getPeekWidth(offset: MLBusinessDynamicCoverCarouselConstants.card.peakWidthLandscape),
                                maxHeightCard: MLBusinessDynamicCoverCarouselConstants.card.itemMaxHeightLandscape,
                                edgeInset: MLBusinessDynamicCoverCarouselConstants.card.landscapeInset)
        }
    }
    
    private func getPeekWidth(offset: Float) -> CGFloat {
        return UIScreen.main.bounds.width * CGFloat(offset)
    }
    
    private func setupCollectionView(peekWidth: CGFloat, maxHeightCard: Float, edgeInset: CGFloat = 16.0 ) {
        collectionViewHeightConstraint?.constant = getMaxItemHeight()
        collectionViewHelper.rightCellPeekWidth = (model?.items.count == 1) ? 0 : peekWidth
        collectionViewHelper.edgeInset = edgeInset
        self.maxItemHeight = CGFloat(maxHeightCard)
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: getMaxItemHeight())
        collectionViewHeightConstraint?.isActive = true
    }
}

extension MLBusinessDynamicCoverCarouselView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let content = model?.items[indexPath.row],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MLBusinessDynamicCoverCarouselViewCell.reuseIdentifier, for: indexPath) as? MLBusinessDynamicCoverCarouselViewCell
        else {
            return MLBusinessDynamicCoverCarouselViewCell()
        }
        cell.imageProvider = imageProvider
        cell.update(with: content)
        return cell
    }
}

extension MLBusinessDynamicCoverCarouselView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getItemCardWidth(), height: getMaxItemHeight())
    }
}

extension MLBusinessDynamicCoverCarouselView: CarouselCollectionViewHelperDelegate {
    func carouselDelegateDidScrollToItem(_ carouselDelegate: CarouselCollectionViewHelper) {
        delegate?.dynamicCoverCarouselView(self, didFinishScrolling: visibleItems)
    }
    
    func carouselDelegate(_ carouselDelegate: CarouselCollectionViewHelper, didSelectItemAt indexPath: IndexPath) {
        delegate?.dynamicCoverCarouselView(self, didSelect:items[indexPath.item], at: indexPath.item)
    }
}

