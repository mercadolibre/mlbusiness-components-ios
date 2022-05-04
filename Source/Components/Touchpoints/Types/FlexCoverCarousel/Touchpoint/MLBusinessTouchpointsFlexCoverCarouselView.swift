//
//  MLBusinessTouchpointsFlexCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import Foundation

class MLBusinessTouchpointsFlexCoverCarouselView: MLBusinessTouchpointsBaseView {
    private let collectionView: MLBusinessFlexCoverCarouselView = {
        let collectionView = MLBusinessFlexCoverCarouselView()
        
        return collectionView
    }()

    private var model: MLBusinessFlexCoverCarouselModel?

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
        guard let model = configuration as? MLBusinessFlexCoverCarouselModel else { return }
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
    
//    override func getVisibleItems() -> [Trackable]? {
//        return collectionView.visibleItems
//    }
    
    override func getTouchpointViewHeight(with data: Codable?, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
        guard let model = data as? MLBusinessFlexCoverCarouselModel else { return 0 }
        
        return 160//CGFloat(collectionView.getMaxItemHeight(for: model)) + topInset + bottomInset
    }
    
}

extension MLBusinessTouchpointsFlexCoverCarouselView: MLBusinessFlexCoverCarouselViewDelegate {
    func coverCarouselView(_: MLBusinessFlexCoverCarouselView, didSelect item: MLBusinessFlexCoverCarouselItemModel, at index: Int) {
        
    }
    
    func coverCarouselView(_: MLBusinessFlexCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessFlexCoverCarouselItemModel]?) {
       
    }
}

