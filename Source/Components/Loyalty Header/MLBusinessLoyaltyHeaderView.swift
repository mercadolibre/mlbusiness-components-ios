//
//  MLBusinessLoyaltyHeaderView.swift
//  MLBusinessComponents
//
//  Created by Nicolas Battelli on 16/09/2019.
//

import UIKit

@objc public final class MLBusinessLoyaltyHeaderView: UIView {
    
    let viewData: MLBusinessLoyaltyHeaderData?
    
    private let viewHeight: CGFloat = 60
    private let fillPercentProgress: Bool
    private let titleNumberOfLines: Int = 1
    private let ringSize: CGFloat = 32
    
    private weak var ringView: UICircularProgressRing?
    
    public init(_ viewData: MLBusinessLoyaltyHeaderData, fillPercentProgress: Bool = true) {
        self.viewData = viewData
        self.fillPercentProgress = fillPercentProgress
        super.init(frame: .zero)
        render()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates methods
private extension MLBusinessLoyaltyHeaderView {
    
    private func render() {
        self.prepareForAutolayout()
        
        self.backgroundColor = viewData?.getBackgroundHexaColor().hexaToUIColor()
        
        let titleLabel = buildTitle()
        self.addSubview(titleLabel)
        
        let subTitleLabel = buildSubTitle()
        self.addSubview(subTitleLabel)
        
        let ringView = buildRing()
        self.addSubview(ringView)
        
        makeConstraints(titleLabel, subTitleLabel, ringView)
    }
    
    // MARK: Builders.
    private func buildTitle() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.prepareForAutolayout(.clear)
        titleLabel.numberOfLines = titleNumberOfLines
        titleLabel.text = viewData?.getTitle()
        titleLabel.textColor = viewData?.getTextColor().hexaToUIColor()
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.S_FONT)
        return titleLabel
    }
    
    private func buildSubTitle() -> UILabel {
        let subTitleLabel = UILabel()
        subTitleLabel.prepareForAutolayout(.clear)
        subTitleLabel.numberOfLines = titleNumberOfLines
        subTitleLabel.text = viewData?.getSubtitle()
        subTitleLabel.textColor = viewData?.getTextColor().hexaToUIColor()
        subTitleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.S_FONT)
        return subTitleLabel
    }
    
    private func buildRing() -> UIView {
        let ringNumber = viewData?.getRingNumber() ?? 1
        let ringHexaColor = "FFFFFF"
        let secondaryHexaColor = viewData?.getRingHexaColor() ?? "FFFFFF"
        let ringPercentage = viewData?.getRingPercentage() ?? 0
        
        let ring = UICircularProgressRing()
        ring.prepareForAutolayout(.clear)
        ring.style = .ontop
        ring.maxValue = 1
        ring.minValue = 0
        ring.startAngle = 270
        ring.outerRingWidth = 2
        ring.innerRingWidth = 2
        ring.outerRingColor = UI.Colors.placeHolderColor
        ring.innerCapStyle = .round
        ring.fontColor = ringHexaColor.hexaToUIColor()
        ring.innerRingColor = ringHexaColor.hexaToUIColor()
        ring.outerRingColor = secondaryHexaColor.hexaToUIColor()
        ring.innerCenterText = String(ringNumber)
        ring.shouldShowValueText = false
        ring.font = UIFont.systemFont(ofSize: 20)
        
        if self.fillPercentProgress {
            ring.startProgress(to: CGFloat(ringPercentage), duration: 0)
        }
        return ring
    }
    
    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ subTitleLabel: UILabel, _ ring: UIView) {
        NSLayoutConstraint.activate([
            ring.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ring.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.S_MARGIN),
            ring.heightAnchor.constraint(equalToConstant: ringSize),
            ring.widthAnchor.constraint(equalToConstant: ringSize),
            titleLabel.leftAnchor.constraint(equalTo: ring.rightAnchor, constant: UI.Margin.M_MARGIN),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: UI.Margin.XXS_MARGIN),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            self.heightAnchor.constraint(equalToConstant: viewHeight)
            ])
    }
    
}
