//
//  MLBusinessCoverCarouselContainerView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 02/11/2020.
//

import UIKit

public protocol MLBusinessCoverCarouselContainerViewDelegate: class {
    func coverCarouselContainerView(_: MLBusinessCoverCarouselContainerView, didSelect item: MLBusinessCoverCarouselContainerItemModel, at index: Int)
    
    func coverCarouselContainerView(_: MLBusinessCoverCarouselContainerView, didFinishScrolling visibleItems: [MLBusinessCoverCarouselContainerItemModel]?)
}

public class MLBusinessCoverCarouselContainerView: UIView {
    private var imageProvider: MLBusinessImageProvider?
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    private var items: [MLBusinessCoverCarouselContainerItemModel] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
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
        collectionView.register(MLBusinessCoverCarouselContainerViewCell.self,
                                forCellWithReuseIdentifier: MLBusinessCoverCarouselContainerViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    public weak var delegate: MLBusinessCoverCarouselContainerViewDelegate?
    
    public var shouldHighlightItems = true
    
    public var scrollView: UIScrollView {
        return collectionView
    }
    
    public var visibleItems: [MLBusinessCoverCarouselContainerItemModel]? {
        return collectionView.indexPathsForVisibleItems.compactMap({ items[$0.item] })
    }
    
    public init(with imageProvider: MLBusinessImageProvider?) {
        self.imageProvider = imageProvider
        
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with items: [MLBusinessCoverCarouselContainerItemModel]) {
        self.items = items
        collectionViewHeightConstraint?.constant = getMaxHeight()
        collectionView.reloadData()
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
}

extension MLBusinessCoverCarouselContainerView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: MLBusinessCoverCarouselContainerViewCell.reuseIdentifier,
                                 for: indexPath) as? MLBusinessCoverCarouselContainerViewCell else {
                                    return MLBusinessCoverCarouselContainerViewCell() }
        let item = items[indexPath.row]
        cell.imageProvider = imageProvider
        cell.update(with: item)
        
        return cell
    }
}

extension MLBusinessCoverCarouselContainerView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: getMaxHeight())
    }
    
    private func getMaxHeight() -> CGFloat {
        return items.map({ getViewHeight(for: $0) }).max() ?? 96
    }
    
    private func getViewHeight(for model: MLBusinessCoverCarouselContainerItemModel) -> CGFloat {
        let view = MLBusinessCoverCarouselContainerItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32.0).isActive = true
        view.update(with: model)
        view.setNeedsLayout()
        view.layoutIfNeeded()
        return view.frame.height
    }
}

extension MLBusinessCoverCarouselContainerView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.coverCarouselContainerView(self, didSelect: items[indexPath.item], at: indexPath.item)
    }
    
    private func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return shouldHighlightItems
    }
}

extension MLBusinessCoverCarouselContainerView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.coverCarouselContainerView(self, didFinishScrolling: visibleItems)
    }
}
