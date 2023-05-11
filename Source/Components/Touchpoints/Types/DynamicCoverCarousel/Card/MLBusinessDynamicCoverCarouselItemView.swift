//
//  MLBusinessDynamicCoverCarouselItemView.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 04/11/2022.
//

import Foundation
import UIKit
import MLUI

public class MLBusinessDynamicCoverCarouselItemView: UIView {
    private var content: MLBusinessDynamicCoverCarouselItemModel?
    private let itemConstants = MLBusinessDynamicCoverCarouselConstants.Item.self
    
    var imageProvider: MLBusinessImageProvider {
        didSet {
            mainDescriptionLeftView.imageProvider = imageProvider
            mainDescriptionRightView.imageProvider = imageProvider
            mainSecondaryDescriptionView.imageProvider = imageProvider
        }
    }
        
    private lazy var backgroundImageView: MLBusinessLiveImagesView = {
        let image = MLBusinessLiveImagesView(with: imageProvider)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = itemConstants.backgroundColor.hexaToUIColor()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topPlainImageView: UIImageView = {
        let logoView = UIImageView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    private lazy var middlePlainImageView: UIImageView = {
        let logoView = UIImageView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFit
        logoView.layer.cornerRadius = 24
        return logoView
    }()
    
    private lazy var topContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = itemConstants.footerBackgroundColor.hexaToUIColor()
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        return view
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.numberOfLines = 1
        label.isAccessibilityElement = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var mainDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var mainDescriptionLeftView: MLBusinessMultipleDescriptionView = {
        let view = MLBusinessMultipleDescriptionView(with: imageProvider)
        return view
    }()
    
    private lazy var mainDescriptionRightView: MLBusinessMultipleDescriptionView = {
        let view = MLBusinessMultipleDescriptionView(with: imageProvider)
        return view
    }()
    
    private lazy var mainSecondaryDescriptionView: MLBusinessMultipleDescriptionView = {
        let view = MLBusinessMultipleDescriptionView(with: imageProvider)
        return view
    }()
    
    // TODO: TERMINAR DE IMPLEMENTAR ESTO
    private lazy var footerSecondaryContentView: MLBusinessMultipleDescriptionView = {
        let view = MLBusinessMultipleDescriptionView(with: imageProvider)
        return view
    }()
    
    private var topContentStackViewLeadingConstraint = NSLayoutConstraint()
    private var mainStackViewBottomConstraint = NSLayoutConstraint()
    private var footerLabelConstraints: [NSLayoutConstraint] = []
        
    private lazy var gradientLayer = CAGradientLayer()
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }
    
    private func setup(){
        addSubview(backgroundImageView)
        addSubview(footerView)
        addSubview(gradientView)
        addSubview(topContentStackView)
        mainStackView.addArrangedSubview(mainDescriptionStackView)
        mainStackView.addArrangedSubview(mainSecondaryDescriptionView)
        addSubview(mainStackView)
        updateGradientView()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            topContentStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
            topContentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
        topContentStackViewLeadingConstraint = topContentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        topContentStackViewLeadingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 22),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        footerLabelConstraints = [
            footerLabel.heightAnchor.constraint(equalToConstant: 22),
            footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            footerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ]
                
        NSLayoutConstraint.activate([
            gradientView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            mainDescriptionStackView.heightAnchor.constraint(equalToConstant: 20),
            mainSecondaryDescriptionView.heightAnchor.constraint(equalToConstant: 15),
        ])
    
        mainStackViewBottomConstraint = mainStackView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: 10)
        mainStackViewBottomConstraint.isActive = true
    }
    
    private func updateGradientView() {
        let start = itemConstants.footerBackgroundColor.hexaToUIColor().withAlphaComponent(0)
        let end = start.withAlphaComponent(1)
        
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [start.cgColor, end.cgColor]

        if gradientLayer.superlayer == nil {
            gradientView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = gradientView.bounds
    }
    
    public func update(with content: MLBusinessDynamicCoverCarouselItemModel){
        clear()
        
        if let badges = content.getTopContent() {
            buildTopContent(with: badges)
        }
        
        backgroundImageView.update(coverMedia: content.getCoverMultimedia(), cover: content.getImageHeader())
        
        if let topPlainImage = content.getTopPlainImage() {
x            imageProvider.getImage(key: topPlainImage) { [weak self] image in
                self?.topPlainImageView.image = image
            }

            self.addSubview(topPlainImageView)
            NSLayoutConstraint.activate([
                topPlainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                topPlainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
                middlePlainImageView.heightAnchor.constraint(equalToConstant: 46)
            ])
            topContentStackViewLeadingConstraint = topContentStackView.leadingAnchor.constraint(equalTo: topPlainImageView.trailingAnchor, constant: 12)
        }
            
        if let footer = content.getFooterContent() {
            footerView.backgroundColor = footer.getBackgroundColor()?.hexaToUIColor()
            footerLabel.textColor = footer.getTextColor()?.hexaToUIColor()
            footerLabel.text = footer.getText()
            footerView.addSubview(footerLabel)
            NSLayoutConstraint.activate(footerLabelConstraints)
            mainStackViewBottomConstraint.constant = -12
        }
        
        if let middlePlainImage = content.getMiddlePlainImage() {
            imageProvider.getImage(key: middlePlainImage) { [weak self] image in
                self?.middlePlainImageView.image = image
            }
            
            self.addSubview(middlePlainImageView)
            NSLayoutConstraint.activate([
                middlePlainImageView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -8),
                middlePlainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
                middlePlainImageView.heightAnchor.constraint(equalToConstant: 48),
                middlePlainImageView.widthAnchor.constraint(equalToConstant: 48)
            ])
        }
                
        if let mainDescriptionLeft = content.getMainDescriptionLeft() {
            mainDescriptionLeftView.update(with: mainDescriptionLeft, size: "MEDIUM")
            mainDescriptionStackView.addArrangedSubview(mainDescriptionLeftView)
        }
        
        if let mainDescriptionRight = content.getMainDescriptionRight() {
            buildMainDescriptionRight(with: mainDescriptionRight)
        }
        
        if let secondaryDescription = content.getMainSecondaryDescription() {
            mainSecondaryDescriptionView.update(with: secondaryDescription, size: "SMALL")
        }
    }
    
    private func buildTopContent(with badges: [MLBusinessDynamicCarouselBadgeModel]) {
        for badge in badges {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = badge.getBackgroundColor()?.hexaToUIColor()
            view.layer.cornerRadius = 2
            guard let content = badge.getContent() else { return }
            let viewContent = MLBusinessMultipleDescriptionView(with: imageProvider)
            viewContent.update(with: content, size: "SMALL")
            view.addSubview(viewContent)
            NSLayoutConstraint.activate([
                viewContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 3),
                viewContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
                viewContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
                viewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3)
            ])
            
            topContentStackView.addArrangedSubview(view)
        }
        
        topContentStackView.layoutIfNeeded()
    }
    
    private func buildMainDescriptionRight(with mainDescriptionRight: [MLBusinessMultipleDescriptionModel]){
        mainDescriptionRightView.update(with: mainDescriptionRight)
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainDescriptionRightView)
        NSLayoutConstraint.activate([
            mainDescriptionRightView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainDescriptionRightView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainDescriptionRightView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)
        ])

        mainDescriptionStackView.addArrangedSubview(view)
    }
    
    public func clear() {
        topContentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mainDescriptionStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mainStackViewBottomConstraint.constant = 10
        topContentStackViewLeadingConstraint.constant = 12
        footerView.subviews.forEach { $0.removeFromSuperview() }
        footerView.backgroundColor = itemConstants.footerBackgroundColor.hexaToUIColor()
    }
    
    public func applyAlphaBackgroundImageView(alpha: CGFloat) {
        backgroundImageView.alpha = alpha
    }
}

// MARK: - MLBusinessLiveImagesHelper
extension MLBusinessDynamicCoverCarouselItemView: MLBusinessLiveImagesHelper {
    func play() {
        backgroundImageView.play()
    }
    
    func pause() {
        backgroundImageView.pause()
    }
}
