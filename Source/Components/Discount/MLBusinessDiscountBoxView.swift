//
//  MLBusinessDiscountBoxView.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/29/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLUI

@objc open class MLBusinessDiscountBoxView: UIView {
    // Constants
    private var itemsPerRow: Int = 3
    internal let rowSeparationOffset: CGFloat = UI.Margin.L_MARGIN

    // Vars
    private var maxAllowedNumberOfItems = 6 {
        didSet {
            updateModels(viewData)
        }
    }
    private var viewData: MLBusinessDiscountBoxData?
    private var tapAction: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?
    internal var discountItems: [MLBusinessSingleItemProtocol] = [MLBusinessSingleItemProtocol]() {
        didSet {
            updateUI()
        }
    }

    // UI Elements
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // Constraints
    private var tableViewTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var tableViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()

    // Publics
    public init(_ data: MLBusinessDiscountBoxData) {
        super.init(frame: .zero)
        updateModels(data)
        render()
    }

    /*
     Use this method to update MLBusinessDiscountBoxData.
     You can keep the same component reference and update layout items only.
    */
    public func update(_ data: MLBusinessDiscountBoxData) {
        updateModels(data)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates Methods.
private extension MLBusinessDiscountBoxView {
    private func render() {
        prepareForAutolayout()
        tableView.prepareForAutolayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false

        tableView.register(MLBusinessDiscountTableViewCell.self, forCellReuseIdentifier: MLBusinessDiscountTableViewCell.cellIdentifier)
        addSubview(tableView)
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: self.topAnchor)
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: getTableViewHeight())

        titleLabel.prepareForAutolayout(.clear)
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.L_FONT)
        titleLabel.applyBusinessLabelStyle()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.S_MARGIN),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN)
        ])

        subtitleLabel.prepareForAutolayout(.clear)
        self.addSubview(subtitleLabel)
        subtitleLabel.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.XS_FONT)
        subtitleLabel.applyBusinessLabelStyle()
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.S_MARGIN),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN)
        ])

        NSLayoutConstraint.activate([
            tableViewTopConstraint,
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableViewHeightConstraint
        ])
        updateBoxConstraints()
    }

    private func updateModels(_ newData: MLBusinessDiscountBoxData?) {
        guard let data = newData else { return }
        viewData = data
        itemsPerRow = MLBusinessDiscountBoxView.getNumberOfItemsPerRow(discountItems)
        discountItems = data.getItems().count > maxAllowedNumberOfItems ? Array(data.getItems()[0...maxAllowedNumberOfItems - 1]) : data.getItems()
    }

    private func updateUI() {
        titleLabel.text = viewData?.getTitle?()
        subtitleLabel.text = viewData?.getSubtitle?()
        updateBoxConstraints()
        tableView.reloadData()
    }

    private func updateBoxConstraints() {
        tableViewHeightConstraint.constant = getTableViewHeight()
        if let _ = viewData?.getTitle?(), let _ = viewData?.getSubtitle?() {
            tableViewTopConstraint.constant = UI.Margin.XM_MARGIN * 2 + UI.Margin.L_MARGIN
        } else {
            tableViewTopConstraint.constant = 0
        }
    }
}

// MARK: DataSource functions.
internal extension MLBusinessDiscountBoxView {
    func getNumbersOfRows(_ itemsCount: Int) -> Int {
        let roundedValue = Int(itemsCount/itemsPerRow)
        return itemsCount % itemsPerRow == 0 ? roundedValue : roundedValue + 1
    }

    func getItems(_ index: Int) -> [MLBusinessSingleItemProtocol] {
        var offset = itemsPerRow - 1
        let indexArray = index * itemsPerRow
        if indexArray >= 0 && indexArray + offset >= discountItems.count {
            offset = indexArray + 1 >= discountItems.count ? 0 : 1
        }
        return Array(discountItems[indexArray...indexArray+offset])
    }

    func getTableViewHeight() -> CGFloat {
        let numberOfRows: Int = getNumbersOfRows(discountItems.count)
        return CGFloat(numberOfRows) * MLBusinessDiscountSingleItemView.itemHeight + CGFloat(numberOfRows - 1) * rowSeparationOffset
    }

    class func getNumberOfItemsPerRow(_ discountItems: [MLBusinessSingleItemProtocol]) -> Int {
        return discountItems.count == 4 ? 2 : 3
    }
}

// MARK: MLBusinessUserInteractionProtocol.
extension MLBusinessDiscountBoxView: MLBusinessUserInteractionProtocol {
    func didTap(item: MLBusinessSingleItemProtocol, index: Int, section: Int) {
        if section == 0 {
            tapAction?(index, item.deepLinkForItem(), item.trackIdForItem())
        } else {
            tapAction?(itemsPerRow + index, item.deepLinkForItem(), item.trackIdForItem())
        }
    }
}

// MARK: Public Methods.
extension MLBusinessDiscountBoxView {
    @objc open func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {
        self.tapAction = action
    }
}
