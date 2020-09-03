//
//  MLBusinessHybridCarouselCardDefaultView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 27/07/2020.
//

import Foundation
import MLUI

class MLBusinessHybridCarouselCardDefaultViewCell: MLBusinessHybridCarouselCardTypeViewCell<MLBusinessHybridCarouselCardDefaultView, MLBusinessHybridCarouselCardDefaultModel> {}

class MLBusinessHybridCarouselCardDefaultView: MLBusinessHybridCarouselCardTypeView<MLBusinessHybridCarouselCardDefaultModel> {

    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let topImageImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 36
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        return imageView
    }()

    private let topImageOverlayImageView: UIView = {
        let imageView = UIView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 36
        imageView.clipsToBounds = true
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.04)
        return imageView
    }()
    
    private let topImageAccessoryImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = MLStyleSheetManager.styleSheet.whiteColor.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.isHidden = true
        return imageView
    }()
    
    private let middleVerticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        stackView.axis = .vertical
        return stackView
    }()
    
    private let middleTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(kMLFontsSizeXSmall))
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let middleSubtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        return label
    }()
    
    private let bottomTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(10.0))
        label.textAlignment = .center
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bottomVerticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()

    private let bottomHorizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        stackView.axis = .horizontal
        return stackView
    }()

    private let bottomPrimaryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(26.0))
        label.textAlignment = .center
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bottomSecondaryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(10.0))
        label.textAlignment = .center
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pillView: MLBusinessPillView = {
        let pillView = MLBusinessPillView()
        pillView.translatesAutoresizingMaskIntoConstraints = false
        return pillView
    }()
    
    private var bottomVerticalStackViewTopAnchorConstraint: NSLayoutConstraint?
    private var bottomVerticalStackViewBottomAnchorConstraint: NSLayoutConstraint?
    private var bottomTopHeightAnchorConstraint: NSLayoutConstraint?
    private var bottomBottomAnchorEqualConstraint: NSLayoutConstraint?
    private var bottomBottomAnchorLessThanConstraint: NSLayoutConstraint?
    private var topImageAccessoryImageViewWidthConstraint: NSLayoutConstraint?
    private let topImageAccessoryImageViewHeight = CGFloat(20.0)

    required init() {
        super.init()
        setup()
        setupConstraints()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(containerView)

        containerView.addSubview(topImageImageView)
        containerView.addSubview(topImageOverlayImageView)
        containerView.addSubview(topImageAccessoryImageView)
        containerView.addSubview(middleVerticalStackView)
        containerView.addSubview(bottomVerticalStackView)
    }

    private func setupConstraints() {
        let top = UILayoutGuide()
        let bottom = UILayoutGuide()

        addLayoutGuide(top)
        addLayoutGuide(bottom)
        
        bottomTopHeightAnchorConstraint = top.heightAnchor.constraint(equalTo: bottom.heightAnchor)
        bottomTopHeightAnchorConstraint?.isActive = true
        
        bottomBottomAnchorEqualConstraint = bottom.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomBottomAnchorEqualConstraint?.isActive = true
        
        bottomBottomAnchorLessThanConstraint = bottom.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0.0)
        bottomBottomAnchorLessThanConstraint?.isActive = false
        
        NSLayoutConstraint.activate([
            top.topAnchor.constraint(equalTo: topAnchor),
            top.bottomAnchor.constraint(equalTo: containerView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            bottom.topAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            topImageImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10.0),
            topImageImageView.heightAnchor.constraint(equalToConstant: 72.0),
            topImageImageView.widthAnchor.constraint(equalTo: topImageImageView.heightAnchor),
            topImageImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            topImageOverlayImageView.heightAnchor.constraint(equalToConstant: 72.0),
            topImageOverlayImageView.widthAnchor.constraint(equalTo: topImageOverlayImageView.heightAnchor),
            topImageOverlayImageView.topAnchor.constraint(equalTo: topImageImageView.topAnchor),
            topImageOverlayImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        topImageAccessoryImageViewWidthConstraint = topImageAccessoryImageView.widthAnchor.constraint(equalToConstant: topImageAccessoryImageViewHeight)
        topImageAccessoryImageViewWidthConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            topImageAccessoryImageView.heightAnchor.constraint(equalToConstant: topImageAccessoryImageViewHeight),
            topImageAccessoryImageView.bottomAnchor.constraint(equalTo: topImageImageView.bottomAnchor),
            topImageAccessoryImageView.rightAnchor.constraint(equalTo: topImageImageView.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            middleVerticalStackView.topAnchor.constraint(equalTo: topImageImageView.bottomAnchor, constant: 14.0),
            middleVerticalStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8.0),
            middleVerticalStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8.0),
        ])
        
        bottomVerticalStackViewTopAnchorConstraint = bottomVerticalStackView.topAnchor.constraint(equalTo: middleVerticalStackView.bottomAnchor, constant: 18.0)
        bottomVerticalStackViewTopAnchorConstraint?.isActive = true
        
        bottomVerticalStackViewBottomAnchorConstraint = bottomVerticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16.0)
        bottomVerticalStackViewBottomAnchorConstraint?.isActive = true

        NSLayoutConstraint.activate([
            bottomVerticalStackView.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor, constant: 8.0),
            bottomVerticalStackView.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -8.0),
            bottomVerticalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }

    override func update(with item: MLBusinessHybridCarouselCardDefaultModel) {
        prepareForReuse()
        
        if let topImageKey = item.topImage {
             imageProvider.getImage(key: topImageKey) { image in self.topImageImageView.image = image }
         }
         
        if let topImageAccessoryKey = item.topImageAccessory {
            topImageAccessoryImageView.isHidden = false
            imageProvider.getImage(key: topImageAccessoryKey) { image in
                self.topImageAccessoryImageView.image = image
                if let image = image {
                    self.topImageAccessoryImageViewWidthConstraint?.constant = self.topImageAccessoryImageViewHeight * (image.size.width / image.size.height)
                }
            }
        }
        
        middleTitleLabel.text = item.middleTitle
        middleVerticalStackView.addArrangedSubview(middleTitleLabel)
        
        if let middleSubtitleLabelText = item.middleSubtitle {
            middleSubtitleLabel.text = middleSubtitleLabelText
            middleVerticalStackView.addArrangedSubview(middleSubtitleLabel)
        }
        
        if let bottomTopLabelText = item.bottomTopLabel {
            bottomVerticalStackView.addArrangedSubview(bottomTopLabel)
            bottomTopLabel.text = bottomTopLabelText
        }

        bottomPrimaryLabel.text = item.bottomPrimaryLabel
        bottomHorizontalStackView.addArrangedSubview(bottomPrimaryLabel)

        if let bottomSecondaryLabelText = item.bottomSecondaryLabel {
            bottomSecondaryLabel.text = bottomSecondaryLabelText
            bottomHorizontalStackView.addArrangedSubview(bottomSecondaryLabel)
        }

        if let bottomLabelStatus = item.bottomLabelStatus, bottomLabelStatus.lowercased() == "blocked" {
            bottomTopLabel.textColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.4)
            bottomPrimaryLabel.textColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.4)
            bottomSecondaryLabel.textColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.4)
        } else {
            bottomTopLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
            bottomPrimaryLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
            bottomSecondaryLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
        }

        bottomVerticalStackView.addArrangedSubview(bottomHorizontalStackView)
        
        if let bottomInfo = item.bottomInfo {
            let pillContainerView = UIView(frame: .zero)
            pillContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            pillView.backgroundColor = bottomInfo.format.backgroundColor.hexaToUIColor()
            pillView.tintColor = bottomInfo.format.textColor.hexaToUIColor()
            pillView.text = bottomInfo.label
            if let icon = bottomInfo.icon {
                imageProvider.getImage(key: icon) { image in
                    self.pillView.icon = image
                }
            } else {
                pillView.icon = nil
            }
            pillContainerView.addSubview(pillView)
            pillView.centerXAnchor.constraint(equalTo: pillContainerView.centerXAnchor).isActive = true
            pillView.topAnchor.constraint(equalTo: pillContainerView.topAnchor, constant: 4.0).isActive = true
            pillView.bottomAnchor.constraint(equalTo: pillContainerView.bottomAnchor).isActive = true
            bottomVerticalStackView.addArrangedSubview(pillContainerView)
            bottomVerticalStackViewTopAnchorConstraint?.constant = 10.0
            bottomVerticalStackViewBottomAnchorConstraint?.constant = -10.0
            bottomTopHeightAnchorConstraint?.isActive = true
            bottomBottomAnchorEqualConstraint?.isActive = true
            bottomBottomAnchorLessThanConstraint?.isActive = false

        } else {
            if let bottomPrimaryLabel = item.bottomPrimaryLabel, !bottomPrimaryLabel.isEmpty {
                bottomVerticalStackViewTopAnchorConstraint?.constant = 18.0
                bottomVerticalStackViewBottomAnchorConstraint?.constant = -18.0
                bottomTopHeightAnchorConstraint?.isActive = true
                bottomBottomAnchorEqualConstraint?.isActive = true
                bottomBottomAnchorLessThanConstraint?.isActive = false
            } else {
                bottomVerticalStackViewTopAnchorConstraint?.constant = 0
                bottomVerticalStackViewBottomAnchorConstraint?.constant = -12.0
                bottomTopHeightAnchorConstraint?.isActive = false
                bottomBottomAnchorEqualConstraint?.isActive = false
                bottomBottomAnchorLessThanConstraint?.isActive = true
            }
        }
    }

    override func prepareForReuse() {
        topImageImageView.image = nil
        topImageAccessoryImageView.image = nil
        topImageAccessoryImageView.isHidden = true
        pillView.icon = nil
        middleVerticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomHorizontalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomVerticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
