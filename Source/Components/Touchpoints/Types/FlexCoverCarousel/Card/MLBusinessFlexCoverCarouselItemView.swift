//
//  MLBusinessFlexCoverCarouselItemView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/04/2022.
//

import UIKit
import MLUI

public class MLBusinessFlexCoverCarouselItemView: UIView {
    static let coverHeight: CGFloat = 83
    static let containerHeight: CGFloat = 107
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
    
    private func createPill(with text: String?, color: String?) {
        guard let pillText = text else { return }
        
        bottomPill.text = pillText
        bottomPill.backgroundColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
                
        mainStackView.addArrangedSubview(bottomPill)
    }
    
    private let bottomPill: MLBusinessPillView = {
        let rightBottomInfo = MLBusinessPillView(with: 10.0)
        rightBottomInfo.translatesAutoresizingMaskIntoConstraints = false
        return rightBottomInfo
    }()
    
    private let bottomPillView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private func createMainSection(with item: MLBusinessFlexCoverCarouselItemModel) {
        createMainTitleTop(with: item.getTitle()?.text, color: item.getTitle()?.textColor)
        createMainSubtitle(with: item.getSubtitle()?.text, color: item.getSubtitle()?.textColor)
        createMainDescription(with: item.getMainDescription()?.text, color: item.getMainDescription()?.textColor)
    }
    
    private func createPillSecttion(with item: MLBusinessFlexCoverCarouselItemModel) {
        createPill(with: item.getPill()?.text, color: item.getPill()?.textColor)
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
        addSubview(alphaOverlayView)
        addSubview(mainStackView)
        bottomPillView.addSubview(bottomPill)
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
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            mainStackView.rightAnchor.constraint(equalTo: mainCardContainerView.rightAnchor, constant: 10)
            
        ])
        
    }
    
    public func prepareForReuse() {
        mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        coverImageView.image = nil
    }
}

