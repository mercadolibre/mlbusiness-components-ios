//
//  MLBusinessCoverCarouselContainerView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 02/11/2020.
//

import UIKit

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
        cell.update(with: item)
        
        return cell
    }
    
    func getMaxHeight() -> CGFloat {
        var maxHeight = CGFloat(96.0)

        for item in items {
            maxHeight = max(maxHeight, getViewHeight(with: item))
        }
        collectionViewHeightConstraint?.constant = maxHeight
        return maxHeight
    }
    
    func getViewHeight(with model: MLBusinessCoverCarouselContainerItemModel) -> CGFloat {
        let view = MLBusinessCoverCarouselContainerItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32.0).isActive = true
        view.update(with: model)
        view.setNeedsLayout()
        view.layoutIfNeeded()
        return view.frame.height
    }
}

extension MLBusinessCoverCarouselContainerView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: getMaxHeight())
    }
}

public protocol MLBusinessCoverCarouselContainerViewDelegate: class {
    func coverCarouselContainerView(_: MLBusinessHybridCarouselContainerView, didSelect item: MLBusinessHybridCarouselCardModel, at index: Int)
    func coverCarouselContainerView(_: MLBusinessHybridCarouselContainerView, didFinishScrolling visibleItems: [MLBusinessHybridCarouselCardModel]?)
}

public class MLBusinessCoverCarouselContainerView: UIView {
    private var imageProvider: MLBusinessImageProvider?
    var collectionViewHeightConstraint: NSLayoutConstraint?
    
    public weak var delegate: MLBusinessCoverCarouselContainerViewDelegate?
    
    private var items: [MLBusinessCoverCarouselContainerItemModel] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
    
    public init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with items: [MLBusinessCoverCarouselContainerItemModel]) {
        self.items = items
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
