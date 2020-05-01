//
//  CardCarouselCollectionItemView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

protocol CardCarouselCollectionItemViewProtocol: class {
    func trackPrints(prints: [Trackable]?)
    func trackTap(with selectedIndex: Int?, deeplink: String?, trackingId: String?)
}

class CardCarouselCollectionItemView: UIView {
    weak var delegate: CardCarouselCollectionItemViewProtocol?
    var segmentId: String?
    var typeId: String?

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCarouselCollectionViewCell.self, forCellWithReuseIdentifier: CardCarouselCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()

    var cards: [CardItemModel] = []
    var maxItemHeight = 0.0
    var collectionViewHeightConstraint: NSLayoutConstraint?

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    private func setup() {
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 210)
        collectionViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func clear() {}

    func update(with items: [CardItemModel]) {
        cards = items
        setMaxItemHeight(with: items)
        collectionView.reloadData()
    }

    func setMaxItemHeight(with items: [CardItemModel]) {
        var hasTopLabel = false, hasMainLabel = false, hasTitle = false, hasSubtitle = false
        let spaceToMainLabel = 100.0, topLabelHeight = 14.0, mainLabelHeight = 28.0, titleHeight = 23.0, subtitleHeight = 13.0, spaceToBottom = 12.0
        for item in items {
            if item.topLabel != nil, !hasTopLabel {
                hasTopLabel = true
            }
            if item.mainLabel != nil, !hasMainLabel {
                hasMainLabel = true
            }
            if item.title != nil, !hasTitle {
                hasTitle = true
            }
            if item.subtitle != nil, !hasSubtitle {
                hasSubtitle = true
            }
        }
        maxItemHeight = spaceToMainLabel
            + (hasTopLabel ? topLabelHeight: 0.0)
            + (hasMainLabel ? mainLabelHeight : 0.0)
            + (hasTitle ? titleHeight : 0.0)
            + (hasSubtitle ? subtitleHeight : 0.0)
            + spaceToBottom
        collectionViewHeightConstraint?.constant = CGFloat(maxItemHeight)
    }
}

extension CardCarouselCollectionItemView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 128.0, height: maxItemHeight)
    }
}

extension CardCarouselCollectionItemView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: CardCarouselCollectionViewCell.reuseIdentifier,
                                 for: indexPath) as? CardCarouselCollectionViewCell else { return CardCarouselCollectionViewCell() }
        let card = cards[indexPath.row]
        cell.update(with: card)
        return cell
    }
}

extension CardCarouselCollectionItemView: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let link = cards[indexPath.row].link, let trackingId = cards[indexPath.row].tracking?.trackingId else { return }

        delegate?.trackTap(with: indexPath.row, deeplink: link, trackingId: trackingId)
    }
}

extension CardCarouselCollectionItemView: UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }

    public func scrollViewDidEndDecelerating(_: UIScrollView) {
        delegate?.trackPrints(prints: getTrackables())
    }
}

extension CardCarouselCollectionItemView: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        var trackables = [Trackable]()
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            if cards[indexPath.row] != nil {
                trackables.append(cards[indexPath.row])
            }
        }
        return trackables.count > 0 ? trackables : nil
    }
}
