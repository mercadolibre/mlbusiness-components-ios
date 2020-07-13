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
    public var shouldHighlightItem = true {
        didSet {
            dataHandler.shouldHighlightItem = shouldHighlightItem
        }
    }
    public var shouldCalculateItemWidth = true {
        didSet {
            dataHandler.shouldCalculateItemWidth = shouldCalculateItemWidth
        }
    }
    
    var leftMargin = CGFloat(0.0) {
        didSet {
            dataHandler.leftMargin = leftMargin
        }
    }
    
    static let minimumInteritemSpacing = CGFloat(12.0)
    private var items: [MLBusinessCarouselItemModel] = []
    private var dataHandler: MLBusinessTouchpointsCollectionViewDataHandler = MLBusinessTouchpointsCollectionViewDataHandler()
    private var imageProvider: MLBusinessImageProvider?

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = MLBusinessCarouselContainerView.minimumInteritemSpacing
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MLBusinessTouchpointsCarouselContainerViewCell.self,
                                forCellWithReuseIdentifier: MLBusinessTouchpointsCarouselContainerViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            collectionView.contentInset = contentInset
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider
        super.init(frame: .zero)
        setup()
        setupDataHandler()
        setupConstraints()
    }

    private func setup() {
        addSubview(collectionView)
        collectionView.dataSource = dataHandler
        collectionView.delegate = dataHandler
    }
    
    private func setupDataHandler() {
        dataHandler.delegate = self
        dataHandler.imageProvider = imageProvider
    }

    private func setupConstraints() {
        dataHandler.collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 210)
        dataHandler.collectionViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func getMaxItemHeight(with items: [MLBusinessCarouselItemModel]) -> CGFloat {
        return dataHandler.getMaxItemHeight(with: items)
    }
    
    public func update(with items: [MLBusinessCarouselItemModel]) {
        self.items = items
        dataHandler.update(with: items)
        dataHandler.collectionViewHeightConstraint?.constant = dataHandler.getMaxItemHeight(with: items)
        collectionView.reloadData()
    }

    public func getVisibleItems() -> [MLBusinessCarouselItemModel]? {
        var visibleItems = [MLBusinessCarouselItemModel]()
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            visibleItems.append(items[indexPath.row])
        }
        return visibleItems.count > 0 ? visibleItems : nil
    }
    
    public func getScrollView() -> UIScrollView {
        return collectionView
    }
}

extension MLBusinessCarouselContainerView: MLBusinessTouchpointsCollectionViewDataHandlerDelegate {
    public func carouselContainerView(didSelect item: MLBusinessCarouselItemModel, at index: Int) {
        delegate?.carouselContainerView(self, didSelect: item, at: index)
    }
    
    public func carouselContainerViewDidFinishScrolling() {
        delegate?.carouselContainerView(self, didFinishScrolling: getVisibleItems())
    }
}
