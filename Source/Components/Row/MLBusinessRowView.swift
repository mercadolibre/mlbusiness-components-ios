//
//  MLBusinessRowView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 20/07/2020.
//

import Foundation
import MLUI

public class MLBusinessRowView: UIView {
    private let leftImageImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        return imageView
    }()
    
    private let overlayLeftImageImageView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.backgroundColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.04)
        return view
    }()
    
    private let leftImageAccessoryImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
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
    
    private let mainSecondaryDescriptionContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
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

    private let rightBottomInfoPillView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let rightBottomInfoPill: MLBusinessPillView = {
        let rightBottomInfo = MLBusinessPillView(with: 10.0)
        rightBottomInfo.translatesAutoresizingMaskIntoConstraints = false
        return rightBottomInfo
    }()

    private var imageProvider: MLBusinessImageProvider
    private let mainDescriptionView: MLBusinessMultipleDescriptionView
    private let mainSecondaryDescriptionView: MLBusinessMultipleDescriptionView

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        self.mainDescriptionView = MLBusinessMultipleDescriptionView(with: self.imageProvider)
        self.mainSecondaryDescriptionView = MLBusinessMultipleDescriptionView(with: self.imageProvider)
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftImageImageView)
        addSubview(overlayLeftImageImageView)
        addSubview(leftImageAccessoryImageView)
        mainSubtitleView.addSubview(mainSubtitleLabel)
        addSubview(mainStackView)
        mainSecondaryDescriptionContainerView.addSubview(mainSecondaryDescriptionView)
        addSubview(rightStackView)
        rightBottomInfoPillView.addSubview(rightBottomInfoPill)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftImageImageView.heightAnchor.constraint(equalToConstant: 64.0),
            leftImageImageView.widthAnchor.constraint(equalTo: leftImageImageView.heightAnchor),
            leftImageImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16.0),
            leftImageImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftImageImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            overlayLeftImageImageView.heightAnchor.constraint(equalToConstant: 64.0),
            overlayLeftImageImageView.widthAnchor.constraint(equalTo: overlayLeftImageImageView.heightAnchor),
            overlayLeftImageImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16.0),
            overlayLeftImageImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            overlayLeftImageImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            leftImageAccessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            leftImageAccessoryImageView.widthAnchor.constraint(equalTo: leftImageAccessoryImageView.heightAnchor),
            leftImageAccessoryImageView.bottomAnchor.constraint(equalTo: leftImageImageView.bottomAnchor),
            leftImageAccessoryImageView.rightAnchor.constraint(equalTo: leftImageImageView.rightAnchor),
        ])
        
         NSLayoutConstraint.activate([
            mainSubtitleLabel.topAnchor.constraint(equalTo: mainSubtitleView.topAnchor, constant: 2.0),
            mainSubtitleLabel.bottomAnchor.constraint(equalTo: mainSubtitleView.bottomAnchor),
            mainSubtitleLabel.leftAnchor.constraint(equalTo: mainSubtitleView.leftAnchor),
            mainSubtitleLabel.rightAnchor.constraint(equalTo: mainSubtitleView.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16.0),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16.0),
            mainStackView.leftAnchor.constraint(equalTo: leftImageImageView.rightAnchor, constant: 14),
            mainStackView.rightAnchor.constraint(lessThanOrEqualTo: rightStackView.leftAnchor, constant: -14),
        ])

        NSLayoutConstraint.activate([
            rightStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 18.0),
            rightStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            rightStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            rightBottomInfoPill.topAnchor.constraint(equalTo: rightBottomInfoPillView.topAnchor, constant: 4.0),
            rightBottomInfoPill.bottomAnchor.constraint(equalTo: rightBottomInfoPillView.bottomAnchor),
            rightBottomInfoPill.leftAnchor.constraint(equalTo: rightBottomInfoPillView.leftAnchor),
            rightBottomInfoPill.rightAnchor.constraint(equalTo: rightBottomInfoPillView.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            mainSecondaryDescriptionView.topAnchor.constraint(equalTo: mainSecondaryDescriptionContainerView.topAnchor, constant: 7.0),
            mainSecondaryDescriptionView.rightAnchor.constraint(equalTo: mainSecondaryDescriptionContainerView.rightAnchor),
            mainSecondaryDescriptionView.bottomAnchor.constraint(equalTo: mainSecondaryDescriptionContainerView.bottomAnchor),
            mainSecondaryDescriptionView.leftAnchor.constraint(equalTo: mainSecondaryDescriptionContainerView.leftAnchor),
        ])
    }

    public func update(with content: MLBusinessRowData) {
        prepareForReuse()
        createLeftSection(with: content)
        createMainSection(with: content)
        createRightSection(with: content)
    }
    
    private func prepareForReuse() {
        rightStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        rightPrimarySecondaryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        leftImageImageView.image = nil
        leftImageAccessoryImageView.image = nil
        rightBottomInfoPill.icon = nil
    }
    
    private func createLeftSection(with content: MLBusinessRowData) {
        createLeftImage(with: content.getLeftImage())
        createLeftImageAccessory(with: content.getLeftImageAccessory())
    }
    
    private func createMainSection(with content: MLBusinessRowData) {
        createMainTitle(with: content.getMainTitle())
        createMainSubtitle(with: content.getMainSubtitle())
        createMainDescription(with: content.getMainDescription())
        createMainSecondaryDescription(with: content.getMainSecondaryDescription?())
    }
    
    private func createRightSection(with content: MLBusinessRowData) {
        createRightTopLabel(with: content.getRightTopLabel())
        createRightPrimaryLabel(with: content.getRightPrimaryLabel())
        createRightSecondaryLabel(with: content.getRightSecondaryLabel())
        createRightMiddleLabel(with: content.getRightMiddleLabel())
        createRightBottomInfo(with: content.getRightBottomInfo())
        setRightLabelStatus(with: content.getRightLabelStatus())
    }
    
    private func createLeftImage(with key: String?) {
        guard let leftImageKey = key else { return }
        imageProvider.getImage(key: leftImageKey) { image in self.leftImageImageView.image = image }
    }
    
    private func createLeftImageAccessory(with key: String?) {
        guard let leftImageAccessoryKey = key else { return }
        imageProvider.getImage(key: leftImageAccessoryKey) { image in self.leftImageAccessoryImageView.image = image }
    }
    
    private func createMainTitle(with text: String?) {
        guard let mainTitleText = text else { return }
        mainTitleLabel.text = mainTitleText
        mainStackView.addArrangedSubview(mainTitleLabel)
    }
    
    private func createMainSubtitle(with text: String?) {
        guard let mainSubtitleText = text else { return }
        mainSubtitleLabel.text = mainSubtitleText
        mainStackView.addArrangedSubview(mainSubtitleView)
    }
    
    private func createMainDescription(with mainDescriptionData: [MLBusinessRowMainDescriptionData]?) {
        guard let mainDescriptionData = mainDescriptionData, mainDescriptionData.count > 0 else { return }
        var mainDescriptionModel: [MLBusinessMultipleDescriptionModel] = []
        mainDescriptionData.forEach { mainDescriptionModel.append(MLBusinessMultipleDescriptionModel(data: $0)) }
        mainDescriptionView.update(with: mainDescriptionModel)
        mainStackView.addArrangedSubview(mainDescriptionView)
    }
    
    private func createMainSecondaryDescription(with mainSecondaryDescriptionModel: [MLBusinessMultipleDescriptionModel]?) {
        guard let model = mainSecondaryDescriptionModel, model.count > 0 else { return }
        mainSecondaryDescriptionView.update(with: model)
        mainStackView.addArrangedSubview(mainSecondaryDescriptionContainerView)
    }
    
    private func createRightTopLabel(with text: String?) {
        guard let rightTopLabelText = text else { return }
        rightTopLabel.text = rightTopLabelText
        rightStackView.addArrangedSubview(rightTopLabel)
    }
    
    private func createRightPrimaryLabel(with text: String?) {
        guard let rightPrimaryLabelText = text else { return }
        rightPrimaryLabel.text = rightPrimaryLabelText
        rightPrimarySecondaryStackView.addArrangedSubview(rightPrimaryLabel)
    }
    
    private func createRightSecondaryLabel(with text: String?) {
        if let rightSecondaryLabelText = text {
            let rightSecondaryLabelView = UIView(frame: .zero)
            rightSecondaryLabelView.translatesAutoresizingMaskIntoConstraints = false
            rightSecondaryLabelView.addSubview(rightSecondaryLabel)

            NSLayoutConstraint.activate([
                rightSecondaryLabel.topAnchor.constraint(equalTo: rightSecondaryLabelView.topAnchor),
                rightSecondaryLabel.leftAnchor.constraint(equalTo: rightSecondaryLabelView.leftAnchor),
                rightSecondaryLabel.rightAnchor.constraint(equalTo: rightSecondaryLabelView.rightAnchor),
                rightSecondaryLabel.bottomAnchor.constraint(equalTo: rightSecondaryLabelView.bottomAnchor, constant: -1),
            ])

            rightSecondaryLabel.text = rightSecondaryLabelText
            rightPrimarySecondaryStackView.addArrangedSubview(rightSecondaryLabelView)
        }

        rightStackView.addArrangedSubview(rightPrimarySecondaryStackView)
    }
    
    private func createRightMiddleLabel(with text: String?) {
        guard let rightMiddleLabelText = text else { return }
        rightMiddleLabel.text = rightMiddleLabelText
        rightStackView.addArrangedSubview(rightMiddleLabel)
    }
    
    private func createRightBottomInfo(with rightBottomInfo: MLBusinessRowRightBottomInfoData?) {
        guard let rightBottomInfo = rightBottomInfo else { return }
        rightBottomInfoPill.backgroundColor = rightBottomInfo.getFormat()?.getBackgroundColor().hexaToUIColor() ?? .clear
        rightBottomInfoPill.tintColor = rightBottomInfo.getFormat()?.getTextColor().hexaToUIColor() ?? .black
        rightBottomInfoPill.text = rightBottomInfo.getLabel()
        if let icon = rightBottomInfo.getIcon() {
            imageProvider.getImage(key: icon) { image in
                self.rightBottomInfoPill.icon = image
            }
        }
        rightStackView.addArrangedSubview(rightBottomInfoPillView)
    }
    
    private func setRightLabelStatus(with rightLabelStatus: String?) {
        if let rightLabelStatus = rightLabelStatus, rightLabelStatus.lowercased() == "blocked" {
            let blockedColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.40)
            rightPrimaryLabel.textColor = blockedColor
            rightSecondaryLabel.textColor = blockedColor
        } else {
            let blackColor = MLStyleSheetManager.styleSheet.blackColor
            rightPrimaryLabel.textColor = blackColor
            rightSecondaryLabel.textColor = blackColor
        }
    }
}

