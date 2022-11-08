//
//  MLBusinessDynamicCoverCarouselViewCell.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 04/11/2022.
//

import Foundation
import UIKit

class MLBusinessDynamicCoverCarouselViewCell: UICollectionViewCell {
    private let cornerRadius: CGFloat = 6

    private lazy var mainContentView: PressableView = {
        let view = PressableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = cornerRadius
        view.pressableAnimator = ShrinkPressableAnimator()
        return view
    }()
    
    private lazy var itemView: MLBusinessDynamicCoverCarouselItemView = {
        let view = MLBusinessDynamicCoverCarouselItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    // MARK: - Internal properties

    static var reuseIdentifier: String {
        return "\(String(describing: self))ReuseIdentifier"
    }

    // MARK: - Init

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    // MARK: - Private methods

    private func setup() {
        contentView.addSubview(mainContentView)
        mainContentView.addSubview(itemView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: mainContentView.topAnchor),
            itemView.leftAnchor.constraint(equalTo: mainContentView.leftAnchor),
            itemView.rightAnchor.constraint(equalTo: mainContentView.rightAnchor),
            itemView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor),
        ])
    }
    
    // MARK: - Internal methods

    override func prepareForReuse() {
        super.prepareForReuse()
        itemView.clear()
    }

    public func update(with content: MLBusinessDynamicCoverCarouselItemModel) {
        itemView.update(with: content)
    }
}
