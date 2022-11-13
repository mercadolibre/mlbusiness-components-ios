//
//  MLBusinessDynamicCoverCarouselItemView.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 04/11/2022.
//

import Foundation
import UIKit
import MLUI

private enum ContentType: String {
     case badge = "badge"
     case text = "text"
     case image = "image"
}

class MLBusinessDynamicCoverCarouselItemView: UIView {
    private var content: MLBusinessDynamicCoverCarouselItemModel?
    private let itemConstants = MLBusinessDynamicCoverCarouselConstants.Item.self
    
    var imageProvider: MLBusinessImageProvider {
        didSet {
            mainDescriptionLeftView.imageProvider = imageProvider
            mainDescriptionRightView.imageProvider = imageProvider
            mainSecondaryDescriptionView.imageProvider = imageProvider
        }
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
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
    
    private lazy var topContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = itemConstants.footerBackgroundColor.hexaToUIColor()
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
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
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var mainDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
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
    
    private var mainStackViewBottomConstraint = NSLayoutConstraint()
    private var mainConstraints: [NSLayoutConstraint] = []
        
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
        footerView.addSubview(footerLabel)
        addSubview(footerView)
        addSubview(gradientView)
        addSubview(topContentView)
        mainStackView.addArrangedSubview(mainDescriptionStackView)
        mainStackView.addArrangedSubview(mainSecondaryDescriptionView)
        addSubview(mainStackView)
        updateGradientView()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 22),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            footerLabel.heightAnchor.constraint(equalToConstant: 22),
            footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            footerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
        
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
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = gradientView.bounds
    }
    
    public func update(with content: MLBusinessDynamicCoverCarouselItemModel){
        
        if let badge = content.topContent {
            for badge in badge {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = badge.getBackgraundColor()?.hexaToUIColor()
                view.layer.cornerRadius = 5
                guard let content = badge.getContent() else { return }
                let viewContent = MLBusinessMultipleDescriptionView(with: imageProvider)
                viewContent.update(with: content, size: "SMALL")
                view.addSubview(viewContent)
            }
        }
        
        if let cover = content.imageHeader {
            imageProvider.getImage(key: cover) { [weak self] image in
                self?.backgroundImageView.image = image
            }
        }
        
        if let footer = content.footerContent {
            footerView.backgroundColor = footer.backgroundColor?.hexaToUIColor()
            footerLabel.textColor = footer.textColor?.hexaToUIColor()
            footerLabel.text = footer.text
            mainStackViewBottomConstraint.constant = -8
        }
        
        if let mainDescriptionLeft = content.mainDescriptionLeft {
            mainDescriptionLeftView.update(with: mainDescriptionLeft, size: "MEDIUM")
        }
        
        if let mainDescriptionRight = content.mainDescriptionRight {
            mainDescriptionRightView.update(with: mainDescriptionRight)
        }
        
        if let secondaryDescription = content.mainSecondaryDescription {
            mainSecondaryDescriptionView.update(with: secondaryDescription, size: "SMALL")
        }
        
        mainDescriptionStackView.addArrangedSubview(mainDescriptionLeftView)
        mainDescriptionStackView.addArrangedSubview(mainDescriptionRightView)
    }
    
    public func clear() {
        backgroundImageView.image = nil
    }
}
