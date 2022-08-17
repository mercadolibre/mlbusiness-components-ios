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
    
    private let logoStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 28
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
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
        
    private lazy var mainCardContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var mainTitleTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.boldSystemFont(ofSize: CGFloat(kMLFontsSizeSmall))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        return label
    }()
    
    private lazy var mainSubtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(6.0))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        return label
    }()
    
    private lazy var pillLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(11.0))
        label.textAlignment = .center
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        return label
    }()
    
    private lazy var bottomPillView: UIView = {
        let rightBottomInfo = UIView(frame: .zero)
        rightBottomInfo.layer.borderWidth = 1
        rightBottomInfo.translatesAutoresizingMaskIntoConstraints = false
        rightBottomInfo.layer.cornerRadius = 8
        return rightBottomInfo
    }()

    private func createMainTitleTop(with text: String?, color: String?) {
        guard let mainTitleTopText = text else { return }
        mainTitleTopLabel.text = mainTitleTopText
        mainTitleTopLabel.textColor = getLabelUIColor(color)
    }
    
    private func createMainSubtitle(with text: String?, color: String?) {
        guard let mainSubtitleText = text else { return }
        mainSubtitleLabel.text = mainSubtitleText
        mainSubtitleLabel.textColor = getLabelUIColor(color)
    }
    
    private func createMainDescription(with text: String?, color: String?) {
        guard let mainDescription = text else { return }
        mainDescriptionLabel.text = mainDescription
        mainDescriptionLabel.textColor = getLabelUIColor(color)
    }
    
    private func createPillLabel(with pill: FlexCoverCarouselPill?) {
        guard let pillText = pill?.text else { return }
        pillLabel.text = pillText
        pillLabel.textColor = getLabelUIColor(pill?.textColor)
        pillLabel.isHidden = false
    }
    
    private func createPillView(with pill: FlexCoverCarouselPill?) {
        let backgroundColor = pill?.backgroundColor ?? "#009EE3"
        let borderColor = pill?.borderColor ?? "#009EE3"
        let borderUiColor = borderColor.hexaToUIColor()
        
        bottomPillView.backgroundColor =  backgroundColor.hexaToUIColor()
        bottomPillView.layer.borderColor = borderUiColor.cgColor
        bottomPillView.isHidden = false
    }
    
    private func createGradientView() {
        let viewAux = UIView()
        viewAux.frame =  CGRect(x: 0, y: 0, width: 500, height: 104)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewAux.bounds
        gradientLayer.colors = [UIColor(red: 0.122, green: 0.161, blue: 0.239, alpha: 0).cgColor,
            UIColor(red: 0.122, green: 0.161, blue: 0.239, alpha: 1).cgColor
          ]
        viewAux.layer.insertSublayer(gradientLayer, at: 0)
        addSubview(viewAux)
        NSLayoutConstraint.activate([
            viewAux.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor),
            viewAux.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            viewAux.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            viewAux.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor)
        ])
    }
    
    private func createLogoView(logos: [FlexCoverCarouselLogo]) {
        for logo in logos {
            let logoView = MLBusinessFlexCoverCarouselLogoViewFactory.provide(logo: logo)
            let constant = (logo.style?.height ?? 0) + 12
            logoStackView.addArrangedSubview(logoView)
            
            NSLayoutConstraint.activate([
                logoStackView.heightAnchor.constraint(equalTo: logoView.heightAnchor),
                logoStackView.bottomAnchor.constraint(equalTo: mainTitleTopLabel.topAnchor, constant: -CGFloat(constant))
            ])
        }
    }
    
    private func createMainSection(with item: MLBusinessFlexCoverCarouselItemModel) {
        createMainTitleTop(with: item.title?.text, color: item.title?.textColor)
        createMainSubtitle(with: item.subtitle?.text, color: item.subtitle?.textColor)
        createMainDescription(with: item.mainDescription?.text, color: item.mainDescription?.textColor)
    }
    
    private func createPillSecttion(with item: MLBusinessFlexCoverCarouselItemModel) {
        if item.pill?.text != nil && item.pill?.text != "" {
            createPillView(with: item.pill)
            createPillLabel(with: item.pill)
        } else {
            bottomPillView.isHidden = true
            pillLabel.isHidden = true
        }
    }
    
    private func createLogoSection(with item: MLBusinessFlexCoverCarouselItemModel) {
        createLogoView(logos: item.logos ?? [])
    }
    
    private func getLabelUIColor(_ textColor: String?) -> UIColor {
        if let color = textColor, !color.isEmpty{
            return color.hexaToUIColor()
        }
        return MLStyleSheetManager.styleSheet.whiteColor
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
        createLogoSection(with: item)
 
    }
    
    public func setHighlighted(_ highlighted: Bool) {
        self.alphaOverlayView.isHidden = !highlighted
    }
    
    public func clear() {
        prepareForReuse()
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        addSubview(coverImageView)
        addSubview(mainCardContainerView)
        createGradientView()
        addSubview(alphaOverlayView)
        addSubview(bottomPillView)
        bottomPillView.addSubview(pillLabel)
        addSubview(mainTitleTopLabel)
        addSubview(mainSubtitleLabel)
        addSubview(mainDescriptionLabel)
        addSubview(containerView)
        containerView.addSubview(logoStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            alphaOverlayView.topAnchor.constraint(equalTo: topAnchor),
            alphaOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            alphaOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            alphaOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: MLBusinessFlexCoverCarouselItemView.coverHeight),
            
            mainCardContainerView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            mainCardContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainCardContainerView.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            mainCardContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCardContainerView.heightAnchor.constraint(equalToConstant:MLBusinessFlexCoverCarouselItemView.containerHeight),
            
            mainTitleTopLabel.bottomAnchor.constraint(equalTo: mainDescriptionLabel.topAnchor, constant: -12),
            mainTitleTopLabel.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor, constant: 16),
            mainTitleTopLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainTitleTopLabel.heightAnchor.constraint(equalToConstant: 18),
            
            mainSubtitleLabel.topAnchor.constraint(equalTo: mainTitleTopLabel.bottomAnchor),
            mainSubtitleLabel.leadingAnchor.constraint(equalTo: mainTitleTopLabel.leadingAnchor),
            mainSubtitleLabel.trailingAnchor.constraint(equalTo: mainTitleTopLabel.trailingAnchor),
            mainSubtitleLabel.heightAnchor.constraint(equalToConstant: 6),
            
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: mainTitleTopLabel.leadingAnchor),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: mainTitleTopLabel.trailingAnchor),
            mainDescriptionLabel.heightAnchor.constraint(equalToConstant: 28),
            mainDescriptionLabel.bottomAnchor.constraint(equalTo: bottomPillView.topAnchor, constant: -8),
            
            bottomPillView.leadingAnchor.constraint(equalTo: mainTitleTopLabel.leadingAnchor),
            bottomPillView.bottomAnchor.constraint(equalTo: mainCardContainerView.bottomAnchor, constant: -12),
            bottomPillView.heightAnchor.constraint(equalToConstant: 16),

            pillLabel.centerYAnchor.constraint(equalTo: bottomPillView.centerYAnchor),
            pillLabel.leadingAnchor.constraint(equalTo: bottomPillView.leadingAnchor, constant: 6),
            pillLabel.trailingAnchor.constraint(equalTo: bottomPillView.trailingAnchor, constant: -6),
            
            logoStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            logoStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: mainTitleTopLabel.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: mainTitleTopLabel.trailingAnchor),
        ])
    }
    
    public func prepareForReuse() {
        coverImageView.image = nil
        logoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mainSubtitleLabel.text = nil
        mainDescriptionLabel.text = nil
        mainTitleTopLabel.text = nil
        pillLabel.text = nil
    }
}
