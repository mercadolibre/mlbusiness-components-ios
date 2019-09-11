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
    private let viewData: MLBusinessDiscountBoxData
    private let itemsPerRow: Int = 3
    private let rowSeparationOffset: CGFloat = UI.Margin.L_MARGIN
    private var tapAction: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?

    public init(_ viewData: MLBusinessDiscountBoxData) {
        self.viewData = viewData
        super.init(frame: .zero)
        render()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Render.
private extension MLBusinessDiscountBoxView {
    private func render() {
        self.prepareForAutolayout()

        let tableView = UITableView()
        tableView.prepareForAutolayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false

        tableView.register(MLBusinessDiscountTableViewCell.self, forCellReuseIdentifier: MLBusinessDiscountTableViewCell.cellIdentifier)
        self.addSubview(tableView)
        tableView.heightAnchor.constraint(equalToConstant: getTableViewHeight()).isActive = true
        var tableViewTopConstraint: NSLayoutConstraint = tableView.topAnchor.constraint(equalTo: self.topAnchor)

        if let title = viewData.getTitle?(), let subtitle = viewData.getSubtitle?() {
            let titleLabel = UILabel()
            titleLabel.prepareForAutolayout(.clear)
            self.addSubview(titleLabel)
            titleLabel.text = title
            titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.L_FONT)
            titleLabel.applyBusinessLabelStyle()
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 1
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.S_MARGIN),
                titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN)
            ])

            let subtitleLabel = UILabel()
            subtitleLabel.prepareForAutolayout(.clear)
            self.addSubview(subtitleLabel)
            subtitleLabel.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.XS_FONT)
            subtitleLabel.applyBusinessLabelStyle()
            subtitleLabel.text = subtitle
            subtitleLabel.textAlignment = .center
            subtitleLabel.numberOfLines = 1
            NSLayoutConstraint.activate([
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.S_MARGIN),
                subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN)
            ])

            tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: UI.Margin.M_MARGIN)
        }

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableViewTopConstraint
        ])
    }
}

// MARK: Delegates TableView.
extension MLBusinessDiscountBoxView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return getNumbersOfRows(viewData.getItems().count)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemsData: [MLBusinessSingleItemProtocol] = getItems(indexPath.section)
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: MLBusinessDiscountTableViewCell.cellIdentifier, for: indexPath) as? MLBusinessDiscountTableViewCell {
            dequeueCell.setupCell(discountItems: itemsData, interactionDelegate: self, section: indexPath.section)
            return dequeueCell
        }
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : rowSeparationOffset
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? nil : UIView()
    }
}

// MARK: DataSource functions.
private extension MLBusinessDiscountBoxView {
    func getNumbersOfRows(_ itemsCount: Int) -> Int {
        let roundedValue = Int(itemsCount/itemsPerRow)
        return itemsCount % itemsPerRow == 0 ? roundedValue : roundedValue + 1
    }

    func getItems(_ index: Int) -> [MLBusinessSingleItemProtocol] {
        var offset = itemsPerRow - 1
        let indexArray = index * itemsPerRow
        if indexArray >= 0 && indexArray + offset >= viewData.getItems().count {
            offset = indexArray + 1 >= viewData.getItems().count ? 0 : 1
        }
        return Array(viewData.getItems()[indexArray...indexArray+offset])
    }

    func getTableViewHeight() -> CGFloat {
        let numberOfRows: Int = getNumbersOfRows(viewData.getItems().count)
        return CGFloat(numberOfRows) * MLBusinessDiscountSingleItemView.itemHeight + CGFloat(numberOfRows - 1) * rowSeparationOffset
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
