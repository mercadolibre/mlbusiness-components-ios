//
//  MLBusinessDownloadAppView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 13/09/2019.
//

import Foundation
import MLUI

@objc open class MLBusinessDownloadAppView: UIView {

    @objc public enum AppSite: Int {
        case ML
        case MP

        internal var getValue: String {
            switch self {
            case .ML: return "MLAppIcon"
            case .MP: return "MPAppIcon"
            }
        }
    }

    private let viewData: MLBusinessDownloadAppData
    private var tapAction: ((_ deepLink: String?) -> Void)?

    //Constants
    private let downloadAppViewHeight: CGFloat = 64
    private let appIconImageHeight: CGFloat = 24
    private let appIconImageWidth: CGFloat = 34
    private let downloadButtonHeight: CGFloat = 32
    private let downloadButtonWidth: CGFloat = 101

    public init(_ viewData: MLBusinessDownloadAppData) {
        self.viewData = viewData
        super.init(frame: .zero)
        render()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates.
extension MLBusinessDownloadAppView {
    private func render() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UI.Colors.downloadAppViewBackgroundColor
        layer.cornerRadius = 6
        heightAnchor.constraint(equalToConstant: downloadAppViewHeight).isActive = true

        let appIcon = UIImageView()
        appIcon.image = MLBusinessResourceManager.shared.getImage(viewData.getAppSite().getValue)
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        appIcon.contentMode = .scaleAspectFit
        self.addSubview(appIcon)
        NSLayoutConstraint.activate([
            appIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            appIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.S_MARGIN),
            appIcon.heightAnchor.constraint(equalToConstant: appIconImageHeight),
            appIcon.widthAnchor.constraint(equalToConstant: appIconImageWidth)
        ])

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.text = viewData.getTitle()
        titleLabel.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.XS_FONT)
        titleLabel.applyBusinessLabelStyle()
        titleLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: appIcon.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: appIcon.rightAnchor, constant: UI.Margin.S_MARGIN)
        ])

        let downloadButton = UIButton()
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(downloadButton)
        downloadButton.layer.cornerRadius = 6
        downloadButton.setTitle(viewData.getButtonTitle(), for: .normal)
        downloadButton.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT)
        downloadButton.backgroundColor = MLStyleSheetManager.styleSheet.secondaryColor
        NSLayoutConstraint.activate([
            downloadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            downloadButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: UI.Margin.S_MARGIN),
            downloadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN),
            downloadButton.heightAnchor.constraint(equalToConstant: downloadButtonHeight),
            downloadButton.widthAnchor.constraint(equalToConstant: downloadButtonWidth)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnButton))
        downloadButton.addGestureRecognizer(tapGesture)
    }

    // MARK: Tap Selector
    @objc private func didTapOnButton() {
        tapAction?(viewData.getButtonDeepLink?())
    }
}

// MARK: Public Methods.
extension MLBusinessDownloadAppView {
    @objc open func addTapAction(_ action: ((_ deepLink: String?) -> Void)?) {
        self.tapAction = action
    }
}
