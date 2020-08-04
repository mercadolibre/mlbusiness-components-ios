//
//  MLBusinessHybridCarouselView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

class MLBusinessHybridCarouselView: MLBusinessTouchpointsBaseView {
    
    override var canOpenMercadoPagoApp: Bool? {
        didSet {
            collectionView.shouldHighlightItem = canOpenMercadoPagoApp ?? true
        }
    }

    private let collectionView: MLBusinessHybridCarouselContainerView = {
        let collectionView = MLBusinessHybridCarouselContainerView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var model: MLBusinessHybridCarouselModel?

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
        guard let model = configuration as? MLBusinessHybridCarouselModel else { return }
        self.model = model
        collectionView.leftMargin = collectionView.contentInset.left
        collectionView.update(with: model.getItems())
    }
    
    override func setAdditionalEdgeInsets(with insets: [String : Any]?) {
        guard var additionalInsets = insets else { return }
        let insets = UIEdgeInsets(top: 0,
                                  left: CGFloat(additionalInsets["left"] as? NSNumber ?? 0),
                                  bottom: 0,
                                  right: CGFloat(additionalInsets["right"] as? NSNumber ?? 0) + 12.0)
        
        additionalInsets["left"] = 0.0
        additionalInsets["right"] = 0.0
        
        super.setAdditionalEdgeInsets(with: additionalInsets)

        collectionView.contentInset = insets
    }
    
    override func getVisibleItems() -> [Trackable]? {
        return collectionView.getVisibleItems()
    }
    
    override func getTouchpointViewHeight(with data: Codable?, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
        guard let model = data as? MLBusinessHybridCarouselModel else { return 0 }
        
        return CGFloat(collectionView.getMaxItemHeight(with: model.getItems())) + topInset + bottomInset
    }
}

extension MLBusinessHybridCarouselView: MLBusinessHybridCarouselContainerViewDelegate {
    func carouselContainerView(_: MLBusinessHybridCarouselContainerView, didSelect item: MLBusinessHybridCarouselCardModel, at index: Int) {
        guard let link = item.link, let trackingId = item.tracking?.trackingId else { return }

        delegate?.trackTap(with: index, deeplink: link, trackingId: trackingId)
    }
    
    func carouselContainerView(_: MLBusinessHybridCarouselContainerView, didFinishScrolling visibleItems: [MLBusinessHybridCarouselCardModel]?) {
        delegate?.trackPrints(prints: visibleItems)
    }
}
