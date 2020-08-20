//
//  MLBusinessMultipleDescriptionView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 19/08/2020.
//

import Foundation
import MLUI

public class MLBusinessMultipleDescriptionView: UIView {
    private let multipleDescriptionStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var imageProvider: MLBusinessImageProvider

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
    
    public func update(with model: [MLBusinessMultipleDescriptionModel]) {
        multipleDescriptionStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for item in model {
            let itemContent = item.getContent()
            let itemColor = item.getColor()?.hexaToUIColor()
            switch item.getType().lowercased() {
            case "image":
                createMainDescriptionImage(with: itemContent, imageColor: itemColor)
            case "text":
                createMainDescriptionLabel(with: itemContent, textColor: itemColor)
            default:
                break
            }
        }
    }
    
    private func createMainDescriptionImage(with imageKey: String, imageColor: UIColor?) {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.tintColor = imageColor
        imageView.image = nil
        imageProvider.getImage(key: imageKey) { image in imageView.image = image?.withRenderingMode(.alwaysTemplate) }
        multipleDescriptionStackView.addArrangedSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    }
    
    private func createMainDescriptionLabel(with text: String, textColor: UIColor?) {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        label.textAlignment = .left
        label.text = text
        label.textColor = textColor
        multipleDescriptionStackView.addArrangedSubview(label)
    }
    
}
