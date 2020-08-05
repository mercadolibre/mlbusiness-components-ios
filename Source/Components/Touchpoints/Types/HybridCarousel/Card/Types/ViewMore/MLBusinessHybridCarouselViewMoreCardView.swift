//
//  MLBusinessHybridCarouselViewMoreCardView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation
import MLUI

class MLBusinessHybridCarouselViewMoreCardViewCell: MLBusinessHybridCarouselCardTypeViewCell<MLBusinessHybridCarouselViewMoreCardView, MLBusinessHybridCarouselViewMoreCardModel> {}

class MLBusinessHybridCarouselViewMoreCardView: MLBusinessHybridCarouselCardTypeView<MLBusinessHybridCarouselViewMoreCardModel> {

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        stackView.axis = .vertical
        return stackView
    }()
    
    private let mainImageImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 36
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        return imageView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(kMLFontsSizeXSmall))
        label.textColor = MLStyleSheetManager.styleSheet.primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    required init() {
        super.init()
        setup()
        setupConstraints()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(verticalStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 12.0),
            verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12.0),
            verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    override func update(with item: MLBusinessHybridCarouselViewMoreCardModel) {
        prepareForReuse()
        
        if let mainImage = item.mainImage {
            imageProvider.getImage(key: mainImage) { image in self.mainImageImageView.image = image }
            verticalStackView.addArrangedSubview(mainImageImageView)
            mainImageImageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
            mainImageImageView.widthAnchor.constraint(equalTo: mainImageImageView.heightAnchor).isActive = true
        }
        
        mainTitleLabel.text =  item.mainTitle?.label
        mainTitleLabel.textColor = item.mainTitle?.format.textColor.hexaToUIColor()
        mainTitleLabel.backgroundColor = item.mainTitle?.format.backgroundColor.hexaToUIColor()
        verticalStackView.addArrangedSubview(mainTitleLabel)
    }

    override func prepareForReuse() {
        mainImageImageView.image = nil
        verticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
