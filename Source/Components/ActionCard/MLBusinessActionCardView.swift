//
//  MLBusinessActionCardView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 19/06/2020.
//

import Foundation
import MLUI

@objcMembers
open class MLBusinessActionCardView: UIView {

    private var viewData: MLBusinessActionCardViewData
    private var tapAction: (() -> Void)?

    public init(_ viewData: MLBusinessActionCardViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
        render()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates
private extension MLBusinessActionCardView {
    func render() {
        prepareForAutolayout()
        layer.cornerRadius = 6
        layer.applyShadow(alpha: 0.12, x: 0, y: 4, blur: 16)

        let icon = buildIcon()
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: UI.Margin.S_MARGIN),
            icon.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -UI.Margin.S_MARGIN),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 94),
            icon.widthAnchor.constraint(equalToConstant: 151),
        ])

        let titleLabel = buildLabel(viewData.getTitle().uppercased(), getFont(viewData.getTitleWeight(), UI.FontSize.S_FONT), viewData.getTitleColor().hexaToUIColor(), viewData.getTitleBackgroundColor().hexaToUIColor())
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UI.Margin.S_MARGIN),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Margin.S_MARGIN),
            titleLabel.rightAnchor.constraint(equalTo: icon.leftAnchor)
        ])

        let affordanceLabel = buildLabel(viewData.getAffordanceText(), UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT), MLStyleSheetManager.styleSheet.secondaryColor, .clear, .left, 2)
        addSubview(affordanceLabel)
        NSLayoutConstraint.activate([
            affordanceLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: UI.Margin.L_MARGIN),
            affordanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Margin.S_MARGIN),
            affordanceLabel.rightAnchor.constraint(equalTo: icon.leftAnchor),
            affordanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UI.Margin.S_MARGIN)
        ])

        let button = UIButton()
        button.prepareForAutolayout(.clear)
        button.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        tapAction?()
    }
}

// MARK: Publics
extension MLBusinessActionCardView {
    @objc open func addTapAction(_ action: (() -> Void)?) {
        self.tapAction = action
    }

    // Change component default background color.
    @objc public func setCustomBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
}
