//
//  MLBusinessDiscountBoxView+TableView.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/14/19.
//

import UIKit

// MARK: Delegates TableView.
extension MLBusinessDiscountBoxView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return getNumbersOfRows(discountItems.count)
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
