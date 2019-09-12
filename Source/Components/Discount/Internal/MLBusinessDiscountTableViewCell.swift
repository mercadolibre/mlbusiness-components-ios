//
//  MLBusinessDiscountSingleItemView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 29/08/2019.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLUI

final class MLBusinessDiscountTableViewCell: UITableViewCell {
    static let cellIdentifier: String = "discountTableViewCell"
    private let stackView = UIStackView(frame: .zero)
    private var itemViews: [MLBusinessDiscountSingleItemView] = [MLBusinessDiscountSingleItemView]()
    private weak var delegate: MLBusinessUserInteractionProtocol?
    private var section: Int = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup Cell.
extension MLBusinessDiscountTableViewCell {
    func setupCell(discountItems: [MLBusinessSingleItemProtocol], interactionDelegate: MLBusinessUserInteractionProtocol? = nil, section: Int) {
        self.section = section
        delegate = interactionDelegate
        updateStackView(discountItems)
    }
}

// MARK: StackView Privates.
extension MLBusinessDiscountTableViewCell {
    private func setupStackView() {
        self.addSubview(stackView)
        stackView.prepareForAutolayout()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func updateStackView(_ items: [MLBusinessSingleItemProtocol]) {
        setStackViewConstraints(items)
        var currentIndex = 0
        for item in items {
            let itemView = MLBusinessDiscountSingleItemView(discountSingleItem: item, itemIndex: currentIndex, itemSection: section)
            itemViews.append(itemView)
            currentIndex = currentIndex + 1
            itemView.delegate = self
            stackView.addArrangedSubview(itemView)
        }
    }

    private func clearStackView() {
        for itemView in itemViews {
            stackView.removeArrangedSubview(itemView)
        }
        itemViews.removeAll()
    }

    private func setStackViewConstraints(_ items: [MLBusinessSingleItemProtocol]) {
        let margin: CGFloat = items.count == 2 ? MLBusinessDiscountSingleItemView.iconImageSize : 0
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin).isActive = true
    }
}

// MARK: MLBusinessUserInteractionProtocol.
extension MLBusinessDiscountTableViewCell: MLBusinessUserInteractionProtocol {
    func didTap(item: MLBusinessSingleItemProtocol, index: Int, section: Int) {
        delegate?.didTap(item: item, index: index, section: section)
    }
}
