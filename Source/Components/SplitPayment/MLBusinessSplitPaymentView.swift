//
//  MLBusinessSplitPaymentView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 19/06/2020.
//

import Foundation
import MLUI

@objcMembers
open class MLBusinessSplitPaymentView: UIView {

    private var viewData: MLBusinessSplitPaymentData
    private var tapAction: ((_ deeplink: String) -> Void)?

    public init(_ viewData: MLBusinessSplitPaymentData) {
        self.viewData = viewData
        super.init(frame: .zero)
        render()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates
private extension MLBusinessSplitPaymentView {
    func render() {
        prepareForAutolayout()
        layer.cornerRadius = 6
        layer.applyShadow(alpha: 0.25, x: 0.3, y: 0.3, blur: 4)

        let icon = buildIcon()
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 94),
            icon.widthAnchor.constraint(equalToConstant: 151),
        ])

        let titleLabel = buildLabel(viewData.getTitle(), getFont(viewData.getTitleWeight(), UI.FontSize.S_FONT), viewData.getTitleColor().hexaToUIColor(), viewData.getTitleBackgroundColor().hexaToUIColor())
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UI.Margin.S_MARGIN),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Margin.S_MARGIN),
            titleLabel.rightAnchor.constraint(equalTo: icon.leftAnchor)
        ])

        let buttonTitle = buildLabel(viewData.getButtonTitle(), UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT), UIColor(red: 0, green: 158, blue: 227, alpha: 1), .clear, .left, 2)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnButton))
        buttonTitle.addGestureRecognizer(tapGesture)
        buttonTitle.isUserInteractionEnabled = true
        addSubview(buttonTitle)
        NSLayoutConstraint.activate([
            buttonTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UI.Margin.XL_MARGIN),
            buttonTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Margin.S_MARGIN),
            buttonTitle.rightAnchor.constraint(equalTo: icon.leftAnchor),
            buttonTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UI.Margin.S_MARGIN)
        ])
    }

    func buildIcon() -> UIImageView {
        let icon = UIImageView()
        icon.prepareForAutolayout(.clear)
        icon.setRemoteImage(imageUrl: viewData.getImageUrl())
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        return icon
    }

    func buildLabel(_ text: String, _ font: UIFont, _ titleColor: UIColor, _ titleBackgroundColor: UIColor, _ textAlignment: NSTextAlignment = .left, _ numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.prepareForAutolayout(titleBackgroundColor)
        label.text = text
        label.font = font
        label.textColor = titleColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }

    func getFont(_ weight: String, _ size: CGFloat) -> UIFont {
        let font: UIFont
        switch weight {
        case "bold":
            font = UIFont.ml_boldSystemFont(ofSize: size)
        case "semi_bold":
            font = UIFont.ml_semiboldSystemFont(ofSize: size)
        case "light":
            font = UIFont.ml_lightSystemFont(ofSize: size)
        default:
            font = UIFont.ml_regularSystemFont(ofSize: size)
        }
        return font
    }

    // MARK: Tap Selector
    @objc func didTapOnButton() {
        tapAction?(viewData.getButtonDeepLink())
    }
}

// MARK: Publics
extension MLBusinessSplitPaymentView {
    @objc open func addTapAction(_ action: ((_ deeplink: String) -> Void)?) {
        self.tapAction = action
    }

    // Change component default background color.
    @objc public func setCustomBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
}
