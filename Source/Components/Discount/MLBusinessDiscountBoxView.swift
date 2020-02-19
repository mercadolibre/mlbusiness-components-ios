//
//  MLBusinessDiscountBoxView.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/29/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLUI

@objcMembers
open class MLBusinessDiscountBoxView: UIView {
    
    // Constants
    private var itemsPerRow: Int = 3

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
    private let container: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.prepareForAutolayout()
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let itemContainer: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.prepareForAutolayout()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

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
        
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        let header = UIStackView(frame: .zero)
        header.prepareForAutolayout()
        header.axis = .vertical
        header.alignment = .fill
        
        header.addArrangedSubview(titleLabel)
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.ML_FONT)
        titleLabel.applyBusinessLabelStyle()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        header.addArrangedSubview(subtitleLabel)
        subtitleLabel.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.XS_FONT)
        subtitleLabel.applyBusinessLabelStyle()
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 1
        
        container.addArrangedSubview(header)
        container.addArrangedSubview(itemContainer)
    }

    private func updateModels(_ newData: MLBusinessDiscountBoxData?) {
        guard let data = newData else { return }
        viewData = data
        discountItems = data.getItems().count > maxAllowedNumberOfItems ? Array(data.getItems()[0...maxAllowedNumberOfItems - 1]) : data.getItems()
        let eventData = getEventDataFrom(discountItems: discountItems)

        if let trackingProvider = viewData?.getDiscountTracker?(), eventData.count > 0 {
            trackingProvider.track(action: "show", eventData: eventData)
        }
    }
    
    private func getEventDataFrom(discountItems: [MLBusinessSingleItemProtocol]) -> [String : Any] {
        var eventData = [[String : Any]]()
        for discountItem in discountItems {
            if let eventDataForItem = discountItem.eventDataForItem?() {
                eventData.append(eventDataForItem)
            }
        }
        return ["items" : eventData]
    }

    private func updateUI() {
        let title = viewData?.getTitle?()
        let subtitle = viewData?.getSubtitle?()
        
        titleLabel.text = title
        subtitleLabel.text = title != nil ? subtitle : nil
        container.spacing = title == nil ? 0 : UI.Margin.L_MARGIN
        itemContainer.subviews.forEach { $0.removeFromSuperview() }
        discountItems.chunked(into: itemsPerRow).enumerated().forEach({ index, row in
            itemContainer.addArrangedSubview(rowWithItems(items: row, startingIndex: itemsPerRow * index))
        })
    }
    
    private func rowWithItems(items: [MLBusinessSingleItemProtocol], startingIndex: Int = 0) -> UIView {
        let row = UIStackView(frame: .zero)
        row.prepareForAutolayout()
        row.axis = .horizontal
        row.alignment = .fill
        row.distribution = .fillEqually
        
        for (index, item) in items.enumerated() {
            let itemView = MLBusinessDiscountSingleItemView(discountSingleItem: item, itemIndex: startingIndex + index, itemSection: 0)
            itemView.delegate = self
            row.addArrangedSubview(itemView)
        }
        
        return row
    }
}

// MARK: MLBusinessUserInteractionProtocol.
extension MLBusinessDiscountBoxView: MLBusinessUserInteractionProtocol {
    func didTap(item: MLBusinessSingleItemProtocol, index: Int, section: Int) {
        if let viewData = viewData, let trackingProvider = viewData.getDiscountTracker?(), let eventDataForItem = item.eventDataForItem?() {
            trackingProvider.track(action: "tap", eventData: eventDataForItem)
        }
        
        tapAction?(index, item.deepLinkForItem(), item.trackIdForItem())
    }
}

// MARK: Public Methods.
extension MLBusinessDiscountBoxView {
    @objc open func addTapAction(_ action: ((_ index: Int, _ deepLink: String?, _ trackId: String?) -> Void)?) {
        self.tapAction = action
    }
}
