//
//  MLBusinessDiscountSingleItemView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 04/09/2019.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import Foundation
import UIKit
import MLUI

internal protocol MLBusinessUserInteractionProtocol: NSObjectProtocol {
    func didTap(item: MLBusinessDiscountSingleItem)
}

final class MLBusinessDiscountSingleItemView: UIView {
    static let itemHeight: CGFloat = 104
    private let discountSingleItem: MLBusinessDiscountSingleItem
    private let iconImageSize: CGFloat = 56

    weak var delegate: MLBusinessUserInteractionProtocol?

    init(discountSingleItem: MLBusinessDiscountSingleItem) {
        self.discountSingleItem = discountSingleItem
        super.init(frame: .zero)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates
extension MLBusinessDiscountSingleItemView {

    private func render() {
        self.backgroundColor = .white
        let icon: CustomUIImageView = CustomUIImageView()
        icon.prepareForAutolayout(.clear)
        icon.loadImage(url: discountSingleItem.iconImageUrl, placeholder: nil, placeHolderRadius: iconImageSize/2)
        self.addSubview(icon)
        icon.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: iconImageSize),
            icon.widthAnchor.constraint(equalToConstant: iconImageSize),
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        let itemTitle = UILabel()
        itemTitle.prepareForAutolayout(.clear)
        self.addSubview(itemTitle)
        itemTitle.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.XXS_FONT)
        itemTitle.applyBusinessLabelStyle()
        itemTitle.text = discountSingleItem.title
        itemTitle.textAlignment = .center
        itemTitle.numberOfLines = 1
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: UI.Margin.XS_MARGIN),
            itemTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        let itemSubtitle = UILabel()
        itemSubtitle.prepareForAutolayout(.clear)
        self.addSubview(itemSubtitle)
        itemSubtitle.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.M_FONT)
        itemSubtitle.applyBusinessLabelStyle()
        itemSubtitle.text = discountSingleItem.subtitle
        itemSubtitle.textAlignment = .center
        itemSubtitle.numberOfLines = 1
        NSLayoutConstraint.activate([
            itemSubtitle.topAnchor.constraint(equalTo: itemTitle.bottomAnchor),
            itemSubtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemSubtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemSubtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        if discountSingleItem.deepLink != nil {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnButton))
            self.addGestureRecognizer(tapGesture)
        }
    }

    // MARK: Tap Selector
    @objc private func didTapOnButton() {
        delegate?.didTap(item: discountSingleItem)
    }
}
