//
//  MLBusinessFlexCoverCarouselItemView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import UIKit
import MLUI

public class MLBusinessFlexCoverCarouselItemView: UIView {
    static let coverHeight: CGFloat = 104
    static let containerHeight: CGFloat = 56
    var imageProvider: MLBusinessImageProvider
    
    private lazy var alphaOverlayView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.04)
        view.isHidden = true
        
        return view
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        
        let logoView = UIImageView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.backgroundColor = .white
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFill
        logoView.layer.borderWidth = 1.0
        logoView.layer.borderColor = UIColor.white.cgColor
        logoView.layer.cornerRadius = 20
        return logoView
    }()
    
    private let mainCardContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    private let mainTitleTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.boldSystemFont(ofSize: CGFloat(kMLFontsSizeXSmall))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let mainDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        return label
    }()
    
    private let mainSubtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(6.0))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        return label
    }()
    
    private let pillLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(11.0))
        label.textAlignment = .center
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        return label
    }()

    private func createMainTitleTop(with text: String?, color: String?) {
        guard let mainTitleTopText = text else { return }
        mainTitleTopLabel.text = mainTitleTopText
        mainTitleTopLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
        mainStackView.addArrangedSubview(mainTitleTopLabel)
    }
    
    private func createMainSubtitle(with text: String?, color: String?) {
        guard let mainSubtitleText = text else { return }
        mainSubtitleLabel.text = mainSubtitleText
        mainSubtitleLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
        mainStackView.addArrangedSubview(mainSubtitleLabel)
    }
    
    private func createMainDescription(with text: String?, color: String?) {
        guard let mainDescription = text else { return }
        mainDescriptionLabel.text = mainDescription
        mainDescriptionLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
        mainStackView.addArrangedSubview(mainDescriptionLabel)
        
    }
    
    private func createPillLabel(with text: String?, color: String?) {
        guard let pillDescription = text else { return }
        pillLabel.text = pillDescription
        pillLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
    }
    
    private func createPillView(color: String?) {
        bottomPillView.backgroundColor =  color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
    }
    
    private func createGradientView(color: String?) {
        gradientContainer.backgroundColor = color?.hexaToUIColor() ?? .clear
    }
    
    private func createLogoView(imageName: String?) {
        if let imageName = imageName {
            imageProvider.getImage(key: imageName) { [weak self] image in
                self?.logoImageView.image = image
            }
            
            
        }
        
    }
    
    private let bottomPillView: UIView = {
        let rightBottomInfo = UIView(frame: .zero)
        rightBottomInfo.translatesAutoresizingMaskIntoConstraints = false
        rightBottomInfo.layer.cornerRadius = 8
        return rightBottomInfo
    }()
    
    private let gradientContainer: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.opacity = 0.30
        return containerView
    }()

    
    private let defaultGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
    private func createMainSection(with item: MLBusinessFlexCoverCarouselItemModel) {
        createMainTitleTop(with: item.getTitle()?.text, color: item.getTitle()?.textColor)
        createMainSubtitle(with: item.getSubtitle()?.text, color: item.getSubtitle()?.textColor)
        createMainDescription(with: item.getMainDescription()?.text, color: item.getMainDescription()?.textColor)
        createGradientView(color: item.backgroundColor)
    }
    
    private func createPillSecttion(with item: MLBusinessFlexCoverCarouselItemModel) {
        createPillView(color: item.getPill()?.backgroundColor)
        createPillLabel(with: item.getPill()?.text, color: item.getPill()?.textColor)
    }
    
    private func createLogoSection(with item: MLBusinessFlexCoverCarouselItemModel) {
        
        createLogoView(imageName: item.logos?[0].image)
    }
        
    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
            
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with item: MLBusinessFlexCoverCarouselItemModel) {
        clear()
        
        if let cover = item.imageHeader{
            imageProvider.getImage(key: cover) { [weak self] image in
                self?.coverImageView.image = image
            }
        }
        
        if let colorString = item.backgroundColor {
            mainCardContainerView.backgroundColor =  colorString.hexaToUIColor()
        }
    
        createMainSection(with: item)
        createPillSecttion(with: item)
        
        if let logos = item.logos {
            logoImageView.isHidden = false
            createLogoSection(with: item)
        }
    }
    
    public func setHighlighted(_ highlighted: Bool) {
        self.alphaOverlayView.isHidden = !highlighted
    }
    
    public func clear() {
        coverImageView.image = nil
        prepareForReuse()
    }
    
    static func height(for model: MLBusinessFlexCoverCarouselItemModel) -> CGFloat {
        let rowLogoHeight: CGFloat = 96
        
        var rowDescriptionHeight: CGFloat = 86
        // MainSecondaryDescription
        
        return coverHeight + max(rowLogoHeight, rowDescriptionHeight)
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        addSubview(coverImageView)
        addSubview(mainCardContainerView)
        addSubview(gradientContainer)
        addSubview(logoImageView)
        addSubview(alphaOverlayView)
        addSubview(mainStackView)
        addSubview(bottomPillView)
        bottomPillView.addSubview(pillLabel)

        logoImageView.isHidden = true
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: MLBusinessFlexCoverCarouselItemView.coverHeight),
            
            mainCardContainerView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            mainCardContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainCardContainerView.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            mainCardContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCardContainerView.heightAnchor.constraint(equalToConstant: MLBusinessFlexCoverCarouselItemView.containerHeight),

            mainStackView.leftAnchor.constraint(equalTo: mainCardContainerView.leftAnchor, constant: 16.0),
            mainStackView.bottomAnchor.constraint(equalTo: bottomPillView.topAnchor, constant: -8),
            mainStackView.rightAnchor.constraint(equalTo: mainCardContainerView.rightAnchor, constant: 10),
            
            bottomPillView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            bottomPillView.bottomAnchor.constraint(equalTo: mainCardContainerView.bottomAnchor, constant: -12),
            bottomPillView.heightAnchor.constraint(equalToConstant: 16),

            pillLabel.centerYAnchor.constraint(equalTo: bottomPillView.centerYAnchor),
            pillLabel.leadingAnchor.constraint(equalTo: bottomPillView.leadingAnchor, constant: 6),
            pillLabel.trailingAnchor.constraint(equalTo: bottomPillView.trailingAnchor, constant: -6),
            
            gradientContainer.leadingAnchor.constraint(equalTo: mainCardContainerView.leadingAnchor),
            gradientContainer.trailingAnchor.constraint(equalTo: mainCardContainerView.trailingAnchor),
            gradientContainer.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            gradientContainer.heightAnchor.constraint(equalToConstant: 40),
            
            logoImageView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -10),
            logoImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
    public func prepareForReuse() {
        mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        coverImageView.image = nil
    }
}

