//
//  MLBusinessDownloadAppView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 13/09/2019.
//

import Foundation
import MLUI

@objc open class MLBusinessDownloadAppView: UIView {

    private let appSite: AppSite
    private let title: String
    private let buttonTitle: String
    private let deepLink: String?
    private var tapAction: ((_ deepLink: String?) -> Void)?

    //Constants
    private let downloadAppViewHeight: CGFloat = 80
    private let appIconImageSize: CGFloat = 40
    private let downloadButtonHeight: CGFloat = 40
    private let downloadButtonWidth: CGFloat = 110

    public init(appSite: AppSite, title: String, buttonTitle: String, deepLink: String? = nil) {
        self.appSite = appSite
        self.title = title
        self.buttonTitle = buttonTitle
        self.deepLink = deepLink
        super.init(frame: .zero)
        render()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum AppSite: String {
    case ML = "MLAppIcon" //todo: add resources names
    case MP = "AppIcon"
}

// MARK: Privates.
extension MLBusinessDownloadAppView {
    private func render() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        self.layer.cornerRadius = 4
        self.heightAnchor.constraint(equalToConstant: downloadAppViewHeight).isActive = true

        let appIcon = UIImageView()
        appIcon.image = UIImage(named: appSite.rawValue)
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        appIcon.contentMode = .scaleAspectFit
        self.addSubview(appIcon)
        NSLayoutConstraint.activate([
            appIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            appIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            appIcon.heightAnchor.constraint(equalToConstant: appIconImageSize),
            appIcon.widthAnchor.constraint(equalToConstant: appIconImageSize)
        ])

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.S_FONT)
        titleLabel.applyBusinessLabelStyle()
        titleLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: appIcon.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: appIcon.rightAnchor, constant: 12)
        ])

        let downloadButton = UIButton()
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(downloadButton)
        downloadButton.layer.cornerRadius = 4
        downloadButton.setTitle(buttonTitle, for: .normal)
        downloadButton.titleLabel?.font = UIFont.ml_lightSystemFont(ofSize: UI.FontSize.S_FONT)
        downloadButton.backgroundColor = MLStyleSheetManager.styleSheet.secondaryColor
        NSLayoutConstraint.activate([
            downloadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            downloadButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 12),
            downloadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            downloadButton.heightAnchor.constraint(equalToConstant: downloadButtonHeight),
            downloadButton.widthAnchor.constraint(equalToConstant: downloadButtonWidth)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnButton))
        downloadButton.addGestureRecognizer(tapGesture)
    }

    // MARK: Tap Selector
    @objc private func didTapOnButton() {
        tapAction?(deepLink)
    }
}

// MARK: Public Methods.
extension MLBusinessDownloadAppView {
    @objc open func addTapAction(_ action: ((_ deepLink: String?) -> Void)?) {
        self.tapAction = action
    }
}
