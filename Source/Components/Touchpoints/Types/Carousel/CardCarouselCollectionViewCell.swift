//
//  CardCarouselCollectionViewCell.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

class CardCarouselCollectionViewCell: UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
            itemView.isHighlighted = isHighlighted
        }
    }

    let itemView = CardItemView()

    static var reuseIdentifier: String {
        return "\(String(describing: self))ReuseIdentifier"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with content: CardItemModel) {
        itemView.update(with: content)
    }

    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(itemView)
    }

    private func setupConstraints() {
        itemView.translatesAutoresizingMaskIntoConstraints = false

        let bottom = UILayoutGuide()

        contentView.addLayoutGuide(bottom)

        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            itemView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            itemView.bottomAnchor.constraint(equalTo: bottom.topAnchor),
            bottom.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 0),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        itemView.clear()
    }
}
