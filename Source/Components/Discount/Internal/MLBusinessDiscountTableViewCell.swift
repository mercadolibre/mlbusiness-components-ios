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
    private weak var delegate: MLBusinessUserInteractionProtocol?
    private var section: Int = 0

    private var stackViewLeadingConstraint: NSLayoutConstraint?
    private var stackViewTrailingConstraint: NSLayoutConstraint?

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
        clearStackView()
        self.section = section
        delegate = interactionDelegate
        updateStackView(discountItems)
    }
}

// MARK: StackView Privates.
extension MLBusinessDiscountTableViewCell {
    private func setupStackView() {
        self.contentView.addSubview(stackView)
        stackView.prepareForAutolayout()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        stackViewLeadingConstraint = stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        stackViewTrailingConstraint = stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        stackViewLeadingConstraint?.isActive = true
        stackViewTrailingConstraint?.isActive = true
    }

    private func updateStackView(_ items: [MLBusinessSingleItemProtocol]) {
        updateStackViewConstraints(items)
        var currentIndex = 0
        for item in items {
            let itemView = MLBusinessDiscountSingleItemView(discountSingleItem: item, itemIndex: currentIndex, itemSection: section)
            currentIndex = currentIndex + 1
            itemView.delegate = self
            stackView.addArrangedSubview(itemView)
        }
    }

    private func clearStackView() {
        var arrangedViews: [UIView] = [UIView]()
        for subArrangedView in stackView.arrangedSubviews {
            arrangedViews.append(subArrangedView)
            stackView.removeArrangedSubview(subArrangedView)
        }
        for subView in arrangedViews {
            for targetConstraint in subView.constraints {
                subView.removeConstraint(targetConstraint)
            }
            subView.removeFromSuperview()
        }
    }

    private func updateStackViewConstraints(_ items: [MLBusinessSingleItemProtocol]) {
        let margin: CGFloat = items.count == 2 ? MLBusinessDiscountSingleItemView.iconImageSize : 0
        stackViewLeadingConstraint?.constant = margin
        stackViewTrailingConstraint?.constant = -margin
    }
}

// MARK: MLBusinessUserInteractionProtocol.
extension MLBusinessDiscountTableViewCell: MLBusinessUserInteractionProtocol {
    func didTap(item: MLBusinessSingleItemProtocol, index: Int, section: Int) {
        delegate?.didTap(item: item, index: index, section: section)
    }
}
