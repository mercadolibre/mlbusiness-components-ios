//
//  MLBusinessCrossSellingBoxView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 16/09/2019.
//

import Foundation
import MLUI

@objc open class MLBusinessCrossSellingBoxView: UIView {

    private let viewData: MLBusinessCrossSellingBoxData
    private var tapAction: ((_ deepLink: String) -> Void)?

    // Constants
    private let crossSellingBoxViewHeight: CGFloat = 92
    private let iconImageSize: CGFloat = 48
    private let buttonHeight: CGFloat = 20

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

        let icon: CustomUIImageView = buildIconImage()
        let title: UILabel = buildTitle(targetView: icon)
        let button: UIButton = buildButton(targetView: title)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnButton))
        button.addGestureRecognizer(tapGesture)
    }

    // MARK: Tap Selector
    @objc private func didTapOnButton() {
        tapAction?(viewData.getButtonDeepLink())
    }

    private func buildIconImage() -> CustomUIImageView {
        let icon = CustomUIImageView()
        icon.loadImage(url: viewData.getIconUrl(), placeholder: nil, placeHolderRadius: iconImageSize/2)
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
            title.centerYAnchor.constraint(equalTo: targetView.centerYAnchor, constant: -UI.Margin.XXS_MARGIN),
            title.leftAnchor.constraint(equalTo: targetView.rightAnchor, constant: UI.Margin.S_MARGIN),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor)
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
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 2
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: UI.Margin.XXXS_MARGIN),
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
