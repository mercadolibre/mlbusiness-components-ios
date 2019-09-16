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

final class MLBusinessDiscountSingleItemView: UIView {
    static let itemHeight: CGFloat = 104
    static let iconImageSize: CGFloat = 56
    private let discountSingleItem: MLBusinessSingleItemProtocol
    private var itemIndex: Int = 0
    private var itemSection: Int = 0

    weak var delegate: MLBusinessUserInteractionProtocol?

    init(discountSingleItem: MLBusinessSingleItemProtocol, itemIndex: Int, itemSection: Int) {
        self.discountSingleItem = discountSingleItem
        self.itemIndex = itemIndex
        self.itemSection = itemSection
        super.init(frame: .zero)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getItemIndex() -> Int {
        return itemIndex
    }
}

// MARK: Privates
extension MLBusinessDiscountSingleItemView {

    private func render() {
        self.backgroundColor = .white
        let icon: CustomUIImageView = CustomUIImageView()
        icon.prepareForAutolayout(.clear)
        icon.loadImage(url: discountSingleItem.iconImageUrlForItem(), placeholder: nil, placeHolderRadius: MLBusinessDiscountSingleItemView.iconImageSize/2)
        self.addSubview(icon)
        icon.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: MLBusinessDiscountSingleItemView.iconImageSize),
            icon.widthAnchor.constraint(equalToConstant: MLBusinessDiscountSingleItemView.iconImageSize),
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        let itemTitle = UILabel()
        itemTitle.prepareForAutolayout(.clear)
        self.addSubview(itemTitle)
        itemTitle.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.XXS_FONT)
        itemTitle.applyBusinessLabelStyle()
        itemTitle.text = discountSingleItem.titleForItem()
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
        itemSubtitle.text = discountSingleItem.subtitleForItem()
        itemSubtitle.textAlignment = .center
        itemSubtitle.numberOfLines = 1
        NSLayoutConstraint.activate([
            itemSubtitle.topAnchor.constraint(equalTo: itemTitle.bottomAnchor),
            itemSubtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemSubtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemSubtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnButton))
        self.addGestureRecognizer(tapGesture)
    }

    // MARK: Tap Selector
    @objc private func didTapOnButton() {
        delegate?.didTap(item: discountSingleItem, index: itemIndex, section: itemSection)
    }
}
