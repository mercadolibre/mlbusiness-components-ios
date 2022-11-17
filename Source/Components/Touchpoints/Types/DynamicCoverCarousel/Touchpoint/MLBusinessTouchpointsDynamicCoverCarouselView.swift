//
//  MLBusinessTouchpointsDynamicCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

class MLBusinessTouchpointsDynamicCoverCarouselView: MLBusinessTouchpointsBaseView {
    
    private let collectionView: MLBusinessDynamicCoverCarouselView = {
        let collectionView = MLBusinessDynamicCoverCarouselView()
        return collectionView
    }()

    private var model: MLBusinessDynamicCoverCarouselModel?

    required init?(configuration: Codable?) {
        super.init(configuration: configuration)
        
        setup()
        setupConstraints()
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    
    override func getTouchpointViewHeight(with data: Codable?, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
        guard let model = data as? MLBusinessDynamicCoverCarouselModel else { return 0 }
        return collectionView.getMaxItemHeight() + topInset + bottomInset
    }
    
    override func update(with configuration: Codable?) {
        guard let model = configuration as? MLBusinessDynamicCoverCarouselModel else { return }
        self.model = model
        collectionView.update(with: model)
    }
}

extension MLBusinessTouchpointsDynamicCoverCarouselView: MLBusinessDynamicCoverCarouselViewDelegate {
    func dynamicCoverCarouselView(_: MLBusinessDynamicCoverCarouselView, didSelect item: MLBusinessDynamicCoverCarouselItemModel, at index: Int) {
    }
    
    func dynamicCoverCarouselView(_: MLBusinessDynamicCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessDynamicCoverCarouselItemModel]?) {
    }
}
