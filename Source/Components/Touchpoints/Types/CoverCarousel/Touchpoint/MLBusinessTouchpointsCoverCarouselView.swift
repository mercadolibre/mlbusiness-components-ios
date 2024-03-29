//
//  MLBusinessTouchpointsCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//

import Foundation

class MLBusinessTouchpointsCoverCarouselView: MLBusinessTouchpointsBaseView {
    private let collectionView: MLBusinessCoverCarouselView = {
        let collectionView = MLBusinessCoverCarouselView()
        
        return collectionView
    }()

    private var model: MLBusinessCoverCarouselModel?

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
        topConstraint = collectionView.topAnchor.constraint(equalTo: topAnchor)
        topConstraint?.isActive = true
        leftConstraint = collectionView.leftAnchor.constraint(equalTo: leftAnchor)
        leftConstraint?.isActive = true
        bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint?.isActive = true
        rightConstraint = collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        rightConstraint?.isActive = true
    }

    override func update(with configuration: Codable?) {
        guard let model = configuration as? MLBusinessCoverCarouselModel else { return }
        self.model = model
        collectionView.update(with: model)
    }
    
    override func setAdditionalEdgeInsets(with insets: [String : Any]?) {
        guard let additionalInsets = insets else { return }
        let insets = UIEdgeInsets(top: CGFloat(truncating: additionalInsets["top"] as? NSNumber ?? 0),
                                  left: CGFloat(truncating: additionalInsets["left"] as? NSNumber ?? 0),
                                  bottom: CGFloat(truncating: additionalInsets["bottom"] as? NSNumber ?? 0),
                                  right: CGFloat(truncating: additionalInsets["right"] as? NSNumber ?? 0))
        
        topConstraint?.constant = insets.top
        bottomConstraint?.constant = -insets.bottom

        collectionView.cardWidth = UIScreen.main.bounds.width - insets.left - insets.right
        collectionView.contentInset.left = insets.left
        collectionView.contentInset.right = insets.right
    }
    
    override func getVisibleItems() -> [Trackable]? {
        return collectionView.visibleItems
    }
    
    override func getTouchpointViewHeight(with data: Codable?, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
        guard let model = data as? MLBusinessCoverCarouselModel else { return 0 }
        
        return CGFloat(collectionView.getMaxItemHeight(for: model)) + topInset + bottomInset
    }
}

extension MLBusinessTouchpointsCoverCarouselView: MLBusinessCoverCarouselViewDelegate {
    func coverCarouselView(_: MLBusinessCoverCarouselView, didSelect item: MLBusinessCoverCarouselItemModel, at index: Int) {
        guard let link = item.link, let trackingId = item.trackingId else { return }
        
        delegate?.trackTap(with: index, deeplink: link, trackingId: trackingId)
    }
    
    func coverCarouselView(_: MLBusinessCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessCoverCarouselItemModel]?) {
        delegate?.trackPrints(prints: visibleItems)
    }
}
