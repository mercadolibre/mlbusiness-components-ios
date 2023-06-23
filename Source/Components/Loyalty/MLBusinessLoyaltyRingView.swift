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
    
    private let viewModel: MLBusinessLoyaltyRowViewModel
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
        self.viewModel = MLBusinessLoyaltyRowViewModel.init(loyaltyRowData: ringViewData)
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
        button.isHidden = viewModel.buttonShouldBeHidden()
        return button
    }
    
    private func buildImageUrl() -> UIImageView {
        let icon = UIImageView()
        icon.layer.cornerRadius =  imageSize / 2
        icon.layer.masksToBounds = true
        icon.isHidden = viewModel.iconShouldBeHidden()
        icon.setRemoteImage(imageUrl: viewData.getImageUrl?() ?? "")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.prepareForAutolayout(.clear)
        icon.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        icon.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        return icon
    }
    
    private func buildRing() -> UICircularProgressRing {
        let ring = RingFactory.create(
            number: viewModel.getRingNumber(),
            hexaColor: viewData.getRingHexaColor?() ?? "",
            percent: viewModel.getRingPercentage(),
            fillPercentage: fillPercentProgress,
            innerCenterText: viewModel.getRingCenterText())
        ring.prepareForAutolayout(.clear)
        ring.isHidden = viewModel.ringShouldBeHidden()
        ring.widthAnchor.constraint(equalToConstant: ringSize).isActive = true
        ring.heightAnchor.constraint(equalToConstant: ringSize).isActive = true
        return ring
    }

    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ subtitleLabel: UILabel, _ button: UIButton, _ ring: UICircularProgressRing, _ img : UIImageView) {
        if ring.isHidden && img.isHidden {
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Margin.M_MARGIN).isActive = true
        } else {
            titleLabel.leadingAnchor.constraint(equalTo: ring.trailingAnchor, constant: UI.Margin.M_MARGIN).isActive = true
            ring.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin).isActive = true
            ring.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            img.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin).isActive = true
            img.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }

        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        if subtitleLabel.text.isNilOrEmpty && button.titleLabel.isNilOrEmpty {
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UI.Margin.XXXS_MARGIN).isActive = true
        }

        if !subtitleLabel.text.isNilOrEmpty {
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UI.Margin.XXXS_MARGIN).isActive = true
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        }

        if button.titleLabel.isNilOrEmpty || button.isHidden {
            if !subtitleLabel.text.isNilOrEmpty {
                subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin).isActive = true
            } else {
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin).isActive = true
            }
        } else {
            if !subtitleLabel.text.isNilOrEmpty {
                button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: UI.Margin.XXXS_MARGIN).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UI.Margin.XXXS_MARGIN).isActive = true
            }
            button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin).isActive = true
        }
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
        ringView?.startProgress(to: CGFloat(viewModel.getRingPercentage()), duration: duration)
    }
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self == nil || self == ""
    }
}

extension Optional where Wrapped == UILabel {
    var isNilOrEmpty: Bool {
        self == nil || self?.text == ""
    }
}
