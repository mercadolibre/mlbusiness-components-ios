//
//  MLBusinessItemDescriptionView.swift
//  MLBusinessComponents
//
//  Created by Nicolas Battelli on 18/09/2019.
//

import UIKit

@objcMembers
public final class MLBusinessItemDescriptionView: UIView {
    private var viewData: MLBusinessItemDescriptionData?
    
    private let viewHeight: CGFloat = 36
    private let iconImageSize: CGFloat = 36
    private let titleNumberOfLines: Int = 2
    
    private weak var iconImageView: UIImageView?
    private weak var titleLabel: UILabel?
    
    public init(_ viewData: MLBusinessItemDescriptionData? = nil) {
        self.viewData = viewData
        super.init(frame: .zero)
        render()
        update()
    }
    
    public func update(_ viewData: MLBusinessItemDescriptionData?) {
        self.viewData = viewData
        update()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates methods
private extension MLBusinessItemDescriptionView {
    
    private func update() {
        titleLabel?.text = viewData?.getTitle()
        if let url = viewData?.getIconImageURL() {
            iconImageView?.setRemoteImage(imageUrl: url, success: { [weak self] loadedImage in
                self?.setupImageView(image: loadedImage)
            })
        }
    }
    
    private func render() {
        self.prepareForAutolayout()
        
        let titleLabel = buildTitle()
        self.addSubview(titleLabel)
        
        let iconImageView = buildIconImageView()
        iconImageView.layer.cornerRadius = iconImageSize / 2
        iconImageView.layer.masksToBounds = true
        self.addSubview(iconImageView)
        
        makeConstraints(titleLabel, iconImageView)
    }
    
    // MARK: Builders.
    private func buildTitle() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.prepareForAutolayout(.clear)
        titleLabel.textColor = UI.Colors.mainLabelColor
        titleLabel.numberOfLines = titleNumberOfLines
        titleLabel.font = UIFont.ml_regularSystemFont(ofSize: UI.FontSize.XS_FONT)
        self.titleLabel = titleLabel
        return titleLabel
    }
    
    private func buildIconImageView() -> UIImageView {
        let iconImageView = UIImageView()
        iconImageView.prepareForAutolayout(.clear)
        self.iconImageView = iconImageView
        return iconImageView
    }
    
    private func setupImageView(image: UIImage) {
        if let imageColor = self.viewData?.getIconHexaColor().hexaToUIColor() {
            self.iconImageView?.backgroundColor = imageColor
            self.iconImageView?.image = image.ml_tintedImage(with: .white)
        } else {
            self.iconImageView?.image = image
        }
    }
    
    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ iconImageView: UIImageView) {
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: iconImageSize),
            iconImageView.widthAnchor.constraint(equalToConstant: iconImageSize),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -UI.Margin.S_MARGIN),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN)
        ])
    }
}
