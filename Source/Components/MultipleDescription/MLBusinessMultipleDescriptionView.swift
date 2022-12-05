//
//  MLBusinessMultipleDescriptionView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 19/08/2020.
//

import Foundation
import MLUI

public class MLBusinessMultipleDescriptionView: UIView {
    private let defaultSizeKey = "Default"

    private let multipleDescriptionStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .horizontal
        return stackView
    }()
    
    var imageProvider: MLBusinessImageProvider

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
        
        addSubview(multipleDescriptionStackView)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            multipleDescriptionStackView.topAnchor.constraint(equalTo: topAnchor),
            multipleDescriptionStackView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor),
            multipleDescriptionStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            multipleDescriptionStackView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
    
    public func update(with model: [MLBusinessMultipleDescriptionModel], size: String? = nil) {
        multipleDescriptionStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for item in model {
            let size = size ?? defaultSizeKey
            let itemContent = item.getContent()
            let itemColor = item.getColor()?.hexaToUIColor()
            let itemStyle = item.getStyle()
            let itemAccessibilityDescription = item.getAccessibilityDescription()
            switch item.getType().lowercased() {
            case "image":
                let imageView = createMainDescriptionImage(with: itemContent, imageColor: itemColor)
                multipleDescriptionStackView.addArrangedSubview(imageView)
                imageView.heightAnchor.constraint(equalToConstant: getImageSize(size)).isActive = true
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            case "text":
                let label = createMainDescriptionLabel(with: itemContent, textColor: itemColor, itemStyle: itemStyle, fontSize: size, accessibilityDescription: itemAccessibilityDescription)
                multipleDescriptionStackView.addArrangedSubview(label)
            default:
                break
            }
        }
    }
    
    private func createMainDescriptionImage(with imageKey: String, imageColor: UIColor?) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.tintColor = imageColor
        imageView.image = nil
        imageProvider.getImage(key: imageKey) { image in imageView.image = image?.withRenderingMode(.alwaysTemplate) }
        return imageView
    }
    
    private func createMainDescriptionLabel(with text: String, textColor: UIColor?, compressible: Bool? = false, itemStyle: MlBusinessMultipleDescriptionStyleModel? = nil, fontSize: String,
                                            accessibilityDescription: String?) -> UILabel {
        let accessibilityLabel = accessibilityDescription ?? text
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = getFont(with: itemStyle?.getFontWeight(), and: fontSize)
        label.textAlignment = .left
        label.text = text
        label.textColor = textColor
        label.accessibilityLabel = AccessibilityUtils.formatCurrencyForAccessibility(with: accessibilityLabel)

        if compressible ?? false {
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        return label
    }
    
    private func getFont(with weight: String?, and size: String?) -> UIFont {
        let size = size ?? defaultSizeKey
        let fontSize = getFontSize(size)
        let fontWeight = weight ?? defaultSizeKey
        switch fontWeight.uppercased() {
        case "BOLD":
            return MLStyleSheetManager.styleSheet.boldSystemFont(ofSize: fontSize)
        case "SEMIBOLD":
            return MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: fontSize)
        default:
            return MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: fontSize)
        }
    }
    
    private func getFontSize(_ size: String) -> CGFloat {
        switch size.uppercased() {
        case "SMALL":
            return CGFloat(kMLFontsSizeXSmall)
        case "MEDIUM":
            return CGFloat(kMLFontsSizeSmall)
        default:
            return CGFloat(kMLFontsSizeXXSmall)
        }
    }
    
    private func getImageSize(_ size: String) -> CGFloat {
        switch size.uppercased() {
        case "SMALL":
            return 14.0
        case "MEDIUM":
            return 16.0
        default:
            return 12.0
        }
    }
    
}
