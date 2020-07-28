//
//  MLBusinessHybridCarouselCardView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 27/07/2020.
//

import Foundation
import MLUI

public class MLBusinessHybridCarouselCardView: UIView {

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
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let middleVerticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
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

    private let pillView: MLBusinessHybridCarosuelPillView = {
        let pillView = MLBusinessHybridCarosuelPillView()
        pillView.translatesAutoresizingMaskIntoConstraints = false
        return pillView
    }()
    
    private var bottomVerticalStackViewTopAnchorConstraint: NSLayoutConstraint?
    private var bottomVerticalStackViewBottomAnchorConstraint: NSLayoutConstraint?

    var imageProvider: MLBusinessImageProvider = MLBusinessURLImageProvider()

    public required init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            topImageImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0),
            topImageImageView.heightAnchor.constraint(equalToConstant: 72.0),
            topImageImageView.widthAnchor.constraint(equalTo: topImageImageView.heightAnchor),
            topImageImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            topImageOverlayImageView.heightAnchor.constraint(equalToConstant: 20.0),
            topImageOverlayImageView.widthAnchor.constraint(equalTo: topImageOverlayImageView.heightAnchor),
            topImageOverlayImageView.topAnchor.constraint(equalTo: topImageImageView.topAnchor),
            topImageOverlayImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            topImageAccessoryImageView.heightAnchor.constraint(equalToConstant: 20.0),
            topImageAccessoryImageView.widthAnchor.constraint(equalTo: topImageOverlayImageView.heightAnchor),
            topImageAccessoryImageView.bottomAnchor.constraint(equalTo: topImageImageView.bottomAnchor),
            topImageAccessoryImageView.rightAnchor.constraint(equalTo: topImageImageView.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            middleVerticalStackView.topAnchor.constraint(equalTo: topImageImageView.bottomAnchor, constant: 12.0),
            middleVerticalStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8.0),
            middleVerticalStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8.0),
        ])
        
        bottomVerticalStackViewTopAnchorConstraint = bottomVerticalStackView.topAnchor.constraint(equalTo: middleVerticalStackView.bottomAnchor, constant: 18.0)
        bottomVerticalStackViewTopAnchorConstraint?.isActive = true
        
        bottomVerticalStackViewBottomAnchorConstraint = bottomVerticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -18.0)
        bottomVerticalStackViewBottomAnchorConstraint?.isActive = true

        NSLayoutConstraint.activate([
            bottomVerticalStackView.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor, constant: 8.0),
            bottomVerticalStackView.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -8.0),
            bottomVerticalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }

    public func update(with item: MLBusinessHybridCarouselCardData) {
        prepareForReuse()
        
        if let topImageKey = item.getTopImage() {
             imageProvider.getImage(key: topImageKey) { image in self.topImageImageView.image = image }
         }
         
         if let topImageAccessoryKey = item.getTopImageAccessory() {
            imageProvider.getImage(key: topImageAccessoryKey) { image in self.topImageAccessoryImageView.image = image }
        }
        
        middleTitleLabel.text = item.getMiddleTitle()
        middleVerticalStackView.addArrangedSubview(middleTitleLabel)
        
        if let middleSubtitleLabelText = item.getMiddleSubtitle() {
            middleSubtitleLabel.text = middleSubtitleLabelText
            middleVerticalStackView.addArrangedSubview(middleSubtitleLabel)
        }
        
        if let bottomTopLabelText = item.getBottomTopLabel() {
            bottomVerticalStackView.addArrangedSubview(bottomTopLabel)
            bottomTopLabel.text = bottomTopLabelText
        }

        bottomPrimaryLabel.text = item.getBottomPrimaryLabel()
        bottomHorizontalStackView.addArrangedSubview(bottomPrimaryLabel)

        if let bottomSecondaryLabelText = item.getBottomSecondaryLabel() {
            bottomSecondaryLabel.text = bottomSecondaryLabelText
            bottomHorizontalStackView.addArrangedSubview(bottomSecondaryLabel)
        }

        if let bottomLabelStatus = item.getBottomLabelStatus(), bottomLabelStatus.lowercased() == "blocked" {
            bottomTopLabel.textColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.4)
            bottomPrimaryLabel.textColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.4)
            bottomSecondaryLabel.textColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.4)
        }

        bottomVerticalStackView.addArrangedSubview(bottomHorizontalStackView)
        
        if let bottomInfo = item.getBottomInfo() {
            let pillContainerView = UIView(frame: .zero)
            pillContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            pillView.backgroundColor = bottomInfo.getFormat()?.getBackgroundColor().hexaToUIColor()
            pillView.tintColor = bottomInfo.getFormat()?.getTextColor().hexaToUIColor()
            pillView.text = bottomInfo.getLabel()
            if let icon = bottomInfo.getIcon() {
                imageProvider.getImage(key: icon) { image in
                    self.pillView.icon = image
                }
            } else {
                pillView.icon = nil
            }
            pillContainerView.addSubview(pillView)
            pillView.centerXAnchor.constraint(equalTo: pillContainerView.centerXAnchor).isActive = true
            pillView.topAnchor.constraint(equalTo: pillContainerView.topAnchor).isActive = true
            pillView.bottomAnchor.constraint(equalTo: pillContainerView.bottomAnchor).isActive = true
            bottomVerticalStackView.addArrangedSubview(pillContainerView)
            bottomVerticalStackViewTopAnchorConstraint?.constant = 10.0
            bottomVerticalStackViewBottomAnchorConstraint?.constant = -10.0
        } else {
            if let bottomPrimaryLabel = item.getBottomPrimaryLabel(), !bottomPrimaryLabel.isEmpty {
                bottomVerticalStackViewTopAnchorConstraint?.constant = 18.0
                bottomVerticalStackViewBottomAnchorConstraint?.constant = -18.0
            } else {
                bottomVerticalStackViewTopAnchorConstraint?.constant = 0
                bottomVerticalStackViewBottomAnchorConstraint?.constant = -12.0
            }
        }
    }

    private func prepareForReuse() {
        topImageImageView.image = nil
        pillView.icon = nil
        middleVerticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomHorizontalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomVerticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
