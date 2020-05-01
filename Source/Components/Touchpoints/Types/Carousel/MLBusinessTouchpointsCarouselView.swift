//
//  MLBusinessTouchpointsCarouselView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

class MLBusinessTouchpointsCarouselView: MLBusinessTouchpointsBaseView {

    private let cardCarouselCollectionItemView: CardCarouselCollectionItemView = {
        let cardCarouselCollectionItemView = CardCarouselCollectionItemView()
        cardCarouselCollectionItemView.translatesAutoresizingMaskIntoConstraints = false
        return cardCarouselCollectionItemView
    }()

    private var model: MLBusinessTouchpointsCarouselModel?

    required init?(configuration: Codable?) {
        super.init(configuration: configuration)
        setup()
        setupConstraints()
        update(with: configuration)
    }

    private func setup() {
        addSubview(cardCarouselCollectionItemView)
        cardCarouselCollectionItemView.delegate = self
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardCarouselCollectionItemView.leftAnchor.constraint(equalTo: leftAnchor),
            cardCarouselCollectionItemView.rightAnchor.constraint(equalTo: rightAnchor),
            cardCarouselCollectionItemView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardCarouselCollectionItemView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }

    override func update(with configuration: Codable?) {
        guard let model = configuration as? MLBusinessTouchpointsCarouselModel else { return }
        self.model = model
        cardCarouselCollectionItemView.update(with: model.getItems())
    }
    
    override func getVisibleItems() -> [Trackable]? {
        return cardCarouselCollectionItemView.getTrackables()
    }
}

extension MLBusinessTouchpointsCarouselView: CardCarouselCollectionItemViewProtocol {
    func trackPrints(prints: [Trackable]?) {
        delegate?.trackPrints(prints: prints)
    }
    
    func trackTap(with selectedIndex: Int?, deeplink: String?, trackingId: String?) {
        delegate?.trackTap(with: selectedIndex, deeplink: deeplink, trackingId: trackingId)
    }
}
