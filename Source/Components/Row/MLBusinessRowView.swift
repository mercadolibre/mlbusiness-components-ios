//
//  MLBusinessRowView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 20/07/2020.
//

import Foundation
import MLUI

public class MLBusinessRowView: UIView {
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let leftImageImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        return imageView
    }()
    
    private let leftImageAccessoryImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        return imageView
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()

    private let mainTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(kMLFontsSizeXSmall))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let mainDescriptionStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.axis = .horizontal
        return stackView
    }()

    private let rightStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .trailing
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()

    private let rightPrimarySecondaryStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        stackView.axis = .horizontal
        return stackView
    }()

    private let rightTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(10.0))
        label.textAlignment = .right
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rightPrimaryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(26.0))
        label.textAlignment = .right
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rightSecondaryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(10.0))
        label.textAlignment = .right
        label.textColor = MLStyleSheetManager.styleSheet.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rightMiddleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        label.textAlignment = .right
        label.textColor = MLStyleSheetManager.styleSheet.greyColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rightBottomInfoPill: MLBusinessPillView = {
        let rightBottomInfo = MLBusinessPillView(with: 16.0)
        rightBottomInfo.translatesAutoresizingMaskIntoConstraints = false
        return rightBottomInfo
    }()

    private let lineView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MLStyleSheetManager.styleSheet.primaryBackgroundColor ?? MLStyleSheetManager.styleSheet.lightGreyColor
        return view
    }()

    private var imageProvider: MLBusinessImageProvider

    public var hideBottomLine: Bool {
        get {
            return lineView.isHidden
        }
        set {
            lineView.isHidden = newValue
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(containerView)
        
        containerView.addSubview(leftImageImageView)
        containerView.addSubview(leftImageAccessoryImageView)

        mainStackView.addArrangedSubview(mainTitleLabel)
        mainStackView.addArrangedSubview(mainSubtitleLabel)
        mainStackView.addArrangedSubview(mainDescriptionStackView)
        containerView.addSubview(mainStackView)

        containerView.addSubview(rightStackView)
        containerView.addSubview(lineView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: lineView.topAnchor),
        ])

        NSLayoutConstraint.activate([
            leftImageImageView.heightAnchor.constraint(equalToConstant: 64.0),
            leftImageImageView.widthAnchor.constraint(equalTo: leftImageImageView.heightAnchor),
            leftImageImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0),
            leftImageImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            leftImageAccessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            leftImageAccessoryImageView.widthAnchor.constraint(equalTo: leftImageAccessoryImageView.heightAnchor),
            leftImageAccessoryImageView.bottomAnchor.constraint(equalTo: leftImageImageView.bottomAnchor),
            leftImageAccessoryImageView.rightAnchor.constraint(equalTo: leftImageImageView.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 16.0),
            mainStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16.0),
            mainStackView.leftAnchor.constraint(equalTo: leftImageImageView.rightAnchor, constant: 14),
            mainStackView.rightAnchor.constraint(lessThanOrEqualTo: rightStackView.leftAnchor, constant: -14),
        ])

        NSLayoutConstraint.activate([
            rightStackView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 28.0),
            rightStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            rightStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rightStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
        ])

        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1.0),
            lineView.leftAnchor.constraint(equalTo: leftAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    public func update(with content: MLBusinessRowData) {
        //CLEAN
        rightStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        rightPrimarySecondaryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mainDescriptionStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        //LEFT
        if let leftImageKey = content.getLeftImage() {
            imageProvider.getImage(key: leftImageKey) { image in
                self.leftImageImageView.image = image
            }
        }
        if let logoImageImageViewKey = content.getLeftImageAccessory() {
            imageProvider.getImage(key: logoImageImageViewKey) { image in
                self.leftImageAccessoryImageView.image = image
            }
        }
        
        //MAIN
        mainTitleLabel.text = content.getMainTitle()
        mainSubtitleLabel.text = content.getMainSubtitle()
        
        if let mainDescription = content.getMainDescription(), mainDescription.count > 0 {
            for item in mainDescription {
                let itemContent = item.getContent()
                let itemColor = item.getColor()?.hexaToUIColor()
                switch item.getType().lowercased() {
                case "image":
                    let imageView = UIImageView()
                    imageProvider.getImage(key: itemContent) { image in
                        imageView.image = image
                    }
                    imageView.tintColor = itemColor
                    mainDescriptionStackView.addArrangedSubview(imageView)
                case "text":
                    let label = UILabel()
                    label.text = itemContent
                    label.textColor = itemColor
                    mainDescriptionStackView.addArrangedSubview(label)
                default:
                    break
                }
            }
        }


        //RIGHT
        if let rightTopLabelText = content.getRightTopLabel() {
            rightTopLabel.text = rightTopLabelText
            rightStackView.addArrangedSubview(rightTopLabel)
        }

        rightPrimaryLabel.text = content.getRightPrimaryLabel()
        rightPrimarySecondaryStackView.addArrangedSubview(rightPrimaryLabel)

        if let rightLabel = content.getRightSecondaryLabel() {
            let rightSecondaryLabelView = UIView(frame: .zero)
            rightSecondaryLabelView.translatesAutoresizingMaskIntoConstraints = false
            rightSecondaryLabelView.addSubview(rightSecondaryLabel)

            NSLayoutConstraint.activate([
                rightSecondaryLabel.topAnchor.constraint(equalTo: rightSecondaryLabelView.topAnchor),
                rightSecondaryLabel.leftAnchor.constraint(equalTo: rightSecondaryLabelView.leftAnchor),
                rightSecondaryLabel.rightAnchor.constraint(equalTo: rightSecondaryLabelView.rightAnchor),
                rightSecondaryLabel.bottomAnchor.constraint(equalTo: rightSecondaryLabelView.bottomAnchor, constant: -1),
            ])

            rightSecondaryLabel.text = rightLabel
            rightPrimarySecondaryStackView.addArrangedSubview(rightSecondaryLabelView)
        }

        rightStackView.addArrangedSubview(rightPrimarySecondaryStackView)

        if let rightMiddleLabelText = content.getRightMiddleLabel() {
            rightMiddleLabel.text = rightMiddleLabelText
            rightStackView.addArrangedSubview(rightMiddleLabel)
        }
                
        if let rightBottomInfo = content.getRightBottomInfo() {
            rightBottomInfoPill.backgroundColor = rightBottomInfo.getFormat()?.getBackgroundColor().hexaToUIColor() ?? .clear
            rightBottomInfoPill.tintColor = rightBottomInfo.getFormat()?.getTextColor().hexaToUIColor() ?? .black
            rightBottomInfoPill.text = rightBottomInfo.getLabel()
            if let icon = rightBottomInfo.getIcon() {
                imageProvider.getImage(key: icon) { image in
                    self.rightBottomInfoPill.icon = image
                }
            } else {
                rightBottomInfoPill.icon = nil
            }
            rightStackView.addArrangedSubview(rightBottomInfoPill)
        }
        
        if let rightLabelStatus = content.getRightLabelStatus(), rightLabelStatus.lowercased() == "blocked" {
            let blockedColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.40)
            rightPrimaryLabel.textColor = blockedColor
            rightSecondaryLabel.textColor = blockedColor
        } else {
            let blackColor = MLStyleSheetManager.styleSheet.blackColor
            rightPrimaryLabel.textColor = blackColor
            rightSecondaryLabel.textColor = blackColor
        }
    }
    
    public func prepareForReuse() {
        rightStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        rightPrimarySecondaryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        leftImageImageView.image = nil
        leftImageAccessoryImageView.image = nil
    }
}

