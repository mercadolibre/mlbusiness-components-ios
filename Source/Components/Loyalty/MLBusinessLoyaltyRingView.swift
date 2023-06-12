//
//  MLBusinessLoyaltyRingView.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/28/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLUI

@objcMembers
open class MLBusinessLoyaltyRingView: UIView {
    let viewData: MLBusinessLoyaltyRingData

    private let verticalMargin: CGFloat = 4
    private let ringSize: CGFloat = 46
    private let buttonHeight: CGFloat = 20
    private let titleNumberOfLines: Int = 3
    private let subtitleNumberOfLines: Int = 0
    private let fillPercentProgress: Bool
    private weak var ringView: UICircularProgressRing?
    private var tapAction: ((_ deepLink: String) -> Void)?
    private let imageSize: CGFloat = 46

    public init(_ ringViewData: MLBusinessLoyaltyRingData, fillPercentProgress: Bool = true) {
        self.viewData = ringViewData
        self.fillPercentProgress = fillPercentProgress
        super.init(frame: .zero)
        render()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates.
extension MLBusinessLoyaltyRingView {
    private func render() {
        self.prepareForAutolayout()

        let titleLabel = buildTitle()
        self.addSubview(titleLabel)
        
        let subtitleLabel = buildSubtitle()
        self.addSubview(subtitleLabel)

        let button = buildButton()
        self.addSubview(button)

        let ring = buildRing()
        self.addSubview(ring)
        self.ringView = ring
        
        let imageUrl = buildImageUrl()
        self.addSubview(imageUrl)
        
        makeConstraints(titleLabel, subtitleLabel, button, ring, imageUrl)
    }
    
    // MARK: Builders.
    private func buildTitle() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.prepareForAutolayout(.clear)
        titleLabel.numberOfLines = titleNumberOfLines
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.S_FONT)
        setBold(
            uiLabel: titleLabel,
            string: viewData.getTitle(),
            uiFontNormal: UIFont.ml_regularSystemFont(ofSize: UI.FontSize.S_FONT),
            uiFontBold: UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.S_FONT)
        )
        titleLabel.applyBusinessLabelStyle()
        return titleLabel
    }
    
    private func buildSubtitle() -> UILabel {
        let subtitleLabel = UILabel()
        subtitleLabel.prepareForAutolayout(.clear)
        subtitleLabel.numberOfLines = subtitleNumberOfLines
        subtitleLabel.font = UIFont.ml_regularSystemFont(ofSize: UI.FontSize.XS_FONT)
        setBold(
            uiLabel: subtitleLabel,
            string: viewData.getSubtitle?() ?? nil,
            uiFontNormal: UIFont.ml_regularSystemFont(ofSize: UI.FontSize.XS_FONT),
            uiFontBold: UIFont.ml_boldSystemFont(ofSize: UI.FontSize.XS_FONT))
        subtitleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.45)
        return subtitleLabel
    }

    private func setBold(uiLabel: UILabel, string: String?, uiFontNormal: UIFont, uiFontBold:UIFont){
        let text = NSMutableAttributedString(string: string ?? "")
        let boldOpenTagRange = text.mutableString.range(of: "<b>")
        let boldCloseTagRange = text.mutableString.range(of: "</b>")
        if (boldCloseTagRange.location > boldOpenTagRange.location) {
            uiLabel.font = uiFontNormal
            text.addAttribute(NSAttributedString.Key.font, value: uiFontBold, range: NSMakeRange(boldOpenTagRange.location, boldCloseTagRange.location-boldOpenTagRange.location))
            text.replaceCharacters(in: boldOpenTagRange, with: "")
            text.replaceCharacters(in: NSMakeRange(boldCloseTagRange.location - boldOpenTagRange.length, boldCloseTagRange.length), with: "")
        }
        uiLabel.attributedText = text
    }

    private func buildButton() -> UIButton {
        let button = UIButton()
        button.prepareForAutolayout(.clear)
        button.setTitle(viewData.getButtonTitle?() ?? "", for: .normal)
        button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT)
        button.setTitleColor(MLStyleSheetManager.styleSheet.secondaryColor, for: .normal)
        button.addTarget(self, action:  #selector(self.didTapOnButton), for: .touchUpInside)
        button.isHidden = viewData.getButtonTitle?() == "" || viewData.getButtonTitle?() == nil || viewData.getButtonDeepLink?() == ""
        return button
    }
    
    private func buildImageUrl() -> UIImageView {
        let icon = UIImageView()
        icon.layer.cornerRadius =  imageSize / 2
        icon.layer.masksToBounds = true
        icon.isHidden = viewData.getImageUrl?() == nil || viewData.getImageUrl?() == ""
        icon.setRemoteImage(imageUrl: viewData.getImageUrl?() ?? "")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.prepareForAutolayout(.clear)
        return icon
    }
    
    private func buildRing() -> UICircularProgressRing {
        let number = Int(truncating: viewData.getRingNumber?() ?? 0)
        let centerRingText = number != 0 ? String(number) : ""
        
        let ring = RingFactory.create(
            number: number,
            hexaColor: viewData.getRingHexaColor?() ?? "",
            percent: Float(truncating: viewData.getRingPercentage?() ?? 0),
            fillPercentage: fillPercentProgress,
            innerCenterText: centerRingText)
        
        ring.isHidden = shouldHideRing()
        
        return ring
    }
    
    private func shouldHideRing() -> Bool {
        return viewData.getRingNumber?() == nil || viewData.getRingHexaColor?() == nil || viewData.getRingPercentage?() == nil || viewData.getRingNumber?() == nil
    }

    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ subtitleLabel: UILabel, _ button: UIButton, _ ring: UICircularProgressRing, _ img : UIImageView) {
        var constraint = [NSLayoutConstraint]()
        if((subtitleLabel.text == nil || subtitleLabel.text == "")
           && (button.titleLabel?.text == nil || button.titleLabel?.text == "")) {
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        } else {
            constraint.append(titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UI.Margin.XXXS_MARGIN))
        }
        constraint.append(titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor))
        constraint.append(subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UI.Margin.XXXS_MARGIN))
        constraint.append(subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor))
        constraint.append(subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor))
        if ring.isHidden && img.isHidden {
            constraint.append(titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Margin.M_MARGIN))
        } else {
            constraint.append(ring.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin))
            constraint.append(ring.leadingAnchor.constraint(equalTo: leadingAnchor))
            constraint.append(ring.widthAnchor.constraint(equalToConstant: ringSize))
            constraint.append(ring.heightAnchor.constraint(equalToConstant: ringSize))
            constraint.append(img.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin))
            constraint.append(img.leadingAnchor.constraint(equalTo: leadingAnchor))
            constraint.append(img.widthAnchor.constraint(equalToConstant: imageSize))
            constraint.append(img.heightAnchor.constraint(equalToConstant: imageSize))
            constraint.append(titleLabel.leadingAnchor.constraint(equalTo: ring.trailingAnchor, constant: UI.Margin.M_MARGIN))
        }
        if button.isHidden {
            constraint.append(subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin))
        } else {
            constraint.append(button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor))
            constraint.append(button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor))
            constraint.append(button.heightAnchor.constraint(equalToConstant: buttonHeight))
            constraint.append(button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin))
        }
        NSLayoutConstraint.activate(constraint)
    }

    // MARK: Tap Selector.
    @objc private func didTapOnButton() {
        tapAction?(viewData.getButtonDeepLink?() ?? "")
    }
}

// MARK: Public Methods.
extension MLBusinessLoyaltyRingView {
    @objc open func addTapAction(_ action: @escaping ((_ deepLink: String) -> Void)) {
        self.tapAction = action
    }

    @objc open func fillPercentProgressWithAnimation(_ duration: TimeInterval = 1.0) {
        ringView?.startProgress(to: CGFloat(viewData.getRingPercentage?() ?? 0), duration: duration)
    }
}
