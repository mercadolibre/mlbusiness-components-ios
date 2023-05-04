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
    private let titleNumberOfLines: Int = 2
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

        let ring = RingFactory.create(
            number: viewData.getRingNumber?() ?? 0,
            hexaColor: viewData.getRingHexaColor?() ?? "",
            percent: viewData.getRingPercentage?() ?? 0,
            fillPercentage: fillPercentProgress,
            innerCenterText: viewData.getRingNumber?() != nil ? String(viewData.getRingNumber!()) : "")
        
        self.addSubview(ring)
        self.ringView = ring
        
        let imageUrl = buildImageUrl()
        self.addSubview(imageUrl)
        
        makeConstraints(titleLabel, subtitleLabel, button, ring, imageUrl)
    }
    
    private func buildImageUrl() -> UIImageView {
        let icon = UIImageView()
        icon.layer.cornerRadius =  imageSize / 2
        icon.layer.masksToBounds = true
        icon.setRemoteImage(imageUrl: viewData.getImageUrl?() ?? "")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.prepareForAutolayout(.clear)
        return icon
    }
    
    // MARK: Builders.
    private func buildTitle() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.prepareForAutolayout(.clear)
        titleLabel.numberOfLines = titleNumberOfLines
        titleLabel.text = viewData.getTitle()
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.S_FONT)
        titleLabel.applyBusinessLabelStyle()
        return titleLabel
    }
    
    private func buildSubtitle() -> UILabel {
        let subtitleLabel = UILabel()
        subtitleLabel.prepareForAutolayout(.clear)
        subtitleLabel.numberOfLines = subtitleNumberOfLines
        subtitleLabel.text = viewData.getSubtitle?() ?? nil
        subtitleLabel.font = UIFont.ml_regularSystemFont(ofSize: UI.FontSize.XS_FONT)
        subtitleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.45)
        return subtitleLabel
    }

    private func buildButton() -> UIButton {
        let button = UIButton()
        button.prepareForAutolayout(.clear)
        button.setTitle(viewData.getButtonTitle(), for: .normal)
        button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT)
        button.setTitleColor(MLStyleSheetManager.styleSheet.secondaryColor, for: .normal)
        button.addTarget(self, action:  #selector(self.didTapOnButton), for: .touchUpInside)
        button.isHidden = viewData.getButtonTitle() == "" || viewData.getButtonDeepLink() == ""
        return button
    }

    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ subtitleLabel: UILabel, _ button: UIButton, _ ring: UICircularProgressRing, _ img : UIImageView) {
        NSLayoutConstraint.activate([
            ring.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin),
            ring.leadingAnchor.constraint(equalTo: leadingAnchor),
            ring.widthAnchor.constraint(equalToConstant: ringSize),
            ring.heightAnchor.constraint(equalToConstant: ringSize),
            img.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin),
            img.leadingAnchor.constraint(equalTo: leadingAnchor),
            img.widthAnchor.constraint(equalToConstant: imageSize),
            img.heightAnchor.constraint(equalToConstant: imageSize),
            titleLabel.topAnchor.constraint(equalTo: ring.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: ring.trailingAnchor, constant: UI.Margin.M_MARGIN),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UI.Margin.XXXS_MARGIN),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonHeight),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin)
        ])
    }

    // MARK: Tap Selector.
    @objc private func didTapOnButton() {
        tapAction?(viewData.getButtonDeepLink())
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
