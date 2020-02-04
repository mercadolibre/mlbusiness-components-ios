//
//  MLBusinessCrossSellingBoxView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 16/09/2019.
//

import Foundation
import MLUI

@objcMembers
open class MLBusinessCrossSellingBoxView: UIView {
    private let viewData: MLBusinessCrossSellingBoxData
    private var tapAction: ((_ deepLink: String) -> Void)?

    // Constants
    private let crossSellingBoxViewHeight: CGFloat = 80
    private let iconImageSize: CGFloat = 48
    private let buttonHeight: CGFloat = 40

    public init(_ viewData: MLBusinessCrossSellingBoxData) {
        self.viewData = viewData
        super.init(frame: .zero)
        render()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates.
extension MLBusinessCrossSellingBoxView {
    private func render() {
        prepareForAutolayout()
        heightAnchor.constraint(equalToConstant: crossSellingBoxViewHeight).isActive = true
        let icon: UIImageView = buildIconImage()
        let title: UILabel = buildTitle(targetView: icon)
        let button: UIButton = buildButton(targetView: title)
        button.contentVerticalAlignment = .top
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnButton))
        button.addGestureRecognizer(tapGesture)
    }

    // MARK: Tap Selector
    @objc private func didTapOnButton() {
        tapAction?(viewData.getButtonDeepLink())
    }

    private func buildIconImage() -> UIImageView {
        let icon = UIImageView()
        icon.layer.cornerRadius =  iconImageSize / 2
        icon.layer.masksToBounds = true
        icon.setRemoteImage(imageUrl: viewData.getIconUrl())
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        self.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.heightAnchor.constraint(equalToConstant: iconImageSize),
            icon.widthAnchor.constraint(equalToConstant: iconImageSize)
        ])
        return icon
    }

    private func buildTitle(targetView: UIView) -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = viewData.getText()
        title.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.XS_FONT)
        title.applyBusinessLabelStyle()
        title.numberOfLines = 2
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: targetView.centerYAnchor, constant: -UI.Margin.XS_MARGIN),
            title.leftAnchor.constraint(equalTo: targetView.rightAnchor, constant: UI.Margin.S_MARGIN),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.XXXS_MARGIN)
        ])
        return title
    }

    private func buildButton(targetView: UIView) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(viewData.getButtonTitle(), for: .normal)
        button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT)
        button.setTitleColor(MLStyleSheetManager.styleSheet.secondaryColor, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleLabel?.numberOfLines = 1
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: targetView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        return button
    }
}

// MARK: Public Methods.
extension MLBusinessCrossSellingBoxView {
    @objc open func addTapAction(action: ((_ deepLink: String) -> Void)?) {
        self.tapAction = action
    }
}
