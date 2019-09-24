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

    private let viewHeight: CGFloat = 55
    private let ringSize: CGFloat = 46
    private let buttonHeight: CGFloat = 20
    private let titleNumberOfLines: Int = 2
    private let fillPercentProgress: Bool
    private weak var ringView: UICircularProgressRing?
    private var tapAction: ((_ deepLink: String) -> Void)?

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

        let button = buildButton()
        self.addSubview(button)

        let ring = RingFactory.create(number: viewData.getRingNumber(), hexaColor: viewData.getRingHexaColor(), percent: viewData.getRingPercentage(), fillPercentage: fillPercentProgress, innerCenterText: String(viewData.getRingNumber()))
        self.addSubview(ring)
        self.ringView = ring
        
        makeConstraints(titleLabel, button, ring)
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

    private func buildButton() -> UIButton {
        let button = UIButton()
        button.prepareForAutolayout(.clear)
        button.setTitle(viewData.getButtonTitle(), for: .normal)
        button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT)
        button.setTitleColor(MLStyleSheetManager.styleSheet.secondaryColor, for: .normal)
        button.addTarget(self, action:  #selector(self.didTapOnButton), for: .touchUpInside)
        return button
    }

    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ button: UIButton, _ ring: UICircularProgressRing) {
        NSLayoutConstraint.activate([
            ring.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ring.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ring.heightAnchor.constraint(equalToConstant: ringSize),
            ring.widthAnchor.constraint(equalToConstant: ringSize),
            titleLabel.leftAnchor.constraint(equalTo: ring.rightAnchor, constant: UI.Margin.M_MARGIN),
            titleLabel.centerYAnchor.constraint(equalTo: ring.centerYAnchor, constant: -UI.Margin.XXS_MARGIN),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonHeight),
            button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            self.heightAnchor.constraint(equalToConstant: viewHeight)
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
        ringView?.startProgress(to: CGFloat(viewData.getRingPercentage()), duration: duration)
    }
}
