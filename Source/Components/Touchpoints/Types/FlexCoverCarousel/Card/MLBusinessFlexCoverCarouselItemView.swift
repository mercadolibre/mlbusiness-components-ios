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
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainSubtitleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let mainSubtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeXSmall))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        return label
    }()
    
    private func createMainTitleTop(with text: String?, color: String?) {
        guard let mainTitleTopText = text else { return }
        mainTitleTopLabel.text = mainTitleTopText
        mainTitleTopLabel.textColor = color?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.blackColor
        mainStackView.addArrangedSubview(mainTitleTopLabel)
    }
    
    private func createMainSubtitle(with text: String?) {
        guard let mainSubtitleText = text else { return }
        mainSubtitleLabel.text = mainSubtitleText
        mainStackView.addArrangedSubview(mainSubtitleView)
    }
    
    private func createMainSection(with item: MLBusinessFlexCoverCarouselItemModel) {
        createMainTitleTop(with: item.getTitle()?.text, color: item.getTitle()?.textColor)
        createMainSubtitle(with: item.getSubtitle()?.text)
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
        createMainSection(with: item)
        
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
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        
        addSubview(mainStackView)
        addSubview(coverImageView)
        addSubview(alphaOverlayView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: MLBusinessFlexCoverCarouselItemView.coverHeight),
            coverImageView.widthAnchor.constraint(equalToConstant: 240),
            
            mainCardContainerView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            mainCardContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainCardContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCardContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCardContainerView.widthAnchor.constraint(equalTo: coverImageView.widthAnchor),
            
            mainStackView.topAnchor.constraint(greaterThanOrEqualTo: mainCardContainerView.topAnchor, constant: 16.0),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16.0),
            mainStackView.leftAnchor.constraint(equalTo: mainCardContainerView.leftAnchor, constant: 14),
            mainStackView.rightAnchor.constraint(lessThanOrEqualTo: mainCardContainerView.rightAnchor, constant: -14),
            
            
        ])
        
    }
    
    public func prepareForReuse() {
        mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        coverImageView.image = nil
    }
}

