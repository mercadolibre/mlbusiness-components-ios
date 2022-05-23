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
        
    private let mainTitleTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.boldSystemFont(ofSize: CGFloat(kMLFontsSizeSmall))
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
    
    private let bottomPillView: UIView = {
        let rightBottomInfo = UIView(frame: .zero)
        rightBottomInfo.translatesAutoresizingMaskIntoConstraints = false
        rightBottomInfo.layer.cornerRadius = 8
        return rightBottomInfo
    }()

    private func createMainTitleTop(with text: String?, color: String?) {
        guard let mainTitleTopText = text else { return }
        mainTitleTopLabel.text = mainTitleTopText
        mainTitleTopLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
    }
    
    private func createMainSubtitle(with text: String?, color: String?) {
        guard let mainSubtitleText = text else { return }
        mainSubtitleLabel.text = mainSubtitleText
        mainSubtitleLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
    }
    
    private func createMainDescription(with text: String?, color: String?) {
        guard let mainDescription = text else { return }
        mainDescriptionLabel.text = mainDescription
        mainDescriptionLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
    }
    
    private func createPillLabel(with text: String?, color: String?) {
        guard let pillDescription = text else { return }
        pillLabel.text = pillDescription
        pillLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
    }
    
    private func createPillView(color: String?) {
        bottomPillView.backgroundColor =  color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
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
    
    private func createLogoView(imageName: String?) {
        if let imageName = imageName {
            imageProvider.getImage(key: imageName) { [weak self] image in
                self?.logoImageView.image = image
            }
        }
    }
    
    private func createMainSection(with item: MLBusinessFlexCoverCarouselItemModel) {
        createMainTitleTop(with: item.getTitle()?.text, color: item.getTitle()?.textColor)
        createMainSubtitle(with: item.getSubtitle()?.text, color: item.getSubtitle()?.textColor)
        createMainDescription(with: item.getMainDescription()?.text, color: item.getMainDescription()?.textColor)
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
        return 0
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        addSubview(coverImageView)
        addSubview(mainCardContainerView)
        createGradientView()
        addSubview(logoImageView)
        addSubview(alphaOverlayView)
        addSubview(bottomPillView)
        bottomPillView.addSubview(pillLabel)
        logoImageView.isHidden = true
        addSubview(mainTitleTopLabel)
        addSubview(mainSubtitleLabel)
        addSubview(mainDescriptionLabel)
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

            logoImageView.bottomAnchor.constraint(equalTo: mainTitleTopLabel.topAnchor, constant: -12),
            logoImageView.leadingAnchor.constraint(equalTo: mainTitleTopLabel.leadingAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    public func prepareForReuse() {
        coverImageView.image = nil
    }
}
