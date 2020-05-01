//
//  MLBusinessTouchpointsCarouselCollectionItemView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation
import MLUI

public class MLBusinessTouchpointsCarouselCollectionItemView: UIView {
    open var isHighlighted: Bool = false {
        didSet {
            setHighlighted(with: isHighlighted)
        }
    }

    private let containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        return containerView
    }()

    private let overlayLogoView: UIView = {
        let overlayLogoView = UIView(frame: .zero)
        overlayLogoView.translatesAutoresizingMaskIntoConstraints = false
        overlayLogoView.layer.cornerRadius = 36
        overlayLogoView.clipsToBounds = true
        overlayLogoView.backgroundColor = MLStyleSheetManager.styleSheet.blackColor.withAlphaComponent(0.04)
        return overlayLogoView
    }()

    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView(frame: .zero)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.cornerRadius = 36
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        return logoImageView
    }()

    private let discountTopLabel: UILabel = {
        let discountTopLabel = UILabel(frame: .zero)
        discountTopLabel.numberOfLines = 1
        discountTopLabel.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(10.0))
        discountTopLabel.textAlignment = .center
        discountTopLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
        discountTopLabel.translatesAutoresizingMaskIntoConstraints = false
        return discountTopLabel
    }()

    private let discountValueVerticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()

    private let discountValueHorizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        stackView.axis = .horizontal
        return stackView
    }()

    private let discountRightValueView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let discountMainLabel: UILabel = {
        let discountMainLabel = UILabel(frame: .zero)
        discountMainLabel.numberOfLines = 1
        discountMainLabel.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(26.0))
        discountMainLabel.textAlignment = .center
        discountMainLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
        discountMainLabel.adjustsFontSizeToFitWidth = true
        discountMainLabel.minimumScaleFactor = 0.9
        discountMainLabel.translatesAutoresizingMaskIntoConstraints = false
        return discountMainLabel
    }()

    private let discountRightLabel: UILabel = {
        let discountRightLabel = UILabel(frame: .zero)
        discountRightLabel.numberOfLines = 1
        discountRightLabel.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(10.0))
        discountRightLabel.textAlignment = .center
        discountRightLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
        discountRightLabel.translatesAutoresizingMaskIntoConstraints = false
        return discountRightLabel
    }()

    private let brandNameLabel: UILabel = {
        let brandNameLabel = UILabel(frame: .zero)
        brandNameLabel.numberOfLines = 1
        brandNameLabel.font = MLStyleSheetManager.styleSheet.semiboldSystemFont(ofSize: CGFloat(kMLFontsSizeXSmall))
        brandNameLabel.textAlignment = .center
        brandNameLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
        brandNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return brandNameLabel
    }()

    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel(frame: .zero)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeXXSmall))
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = MLStyleSheetManager.styleSheet.blackColor
        return subtitleLabel
    }()

    private let pillView: MLBusinessTouchpointsCarouselPillView = {
        let pillView = MLBusinessTouchpointsCarouselPillView(with: 16)
        pillView.translatesAutoresizingMaskIntoConstraints = false
        return pillView
    }()

    private var logoImageViewTopConstraint: NSLayoutConstraint?
    private var discountValueVerticalStackViewTopConstraint: NSLayoutConstraint?
    private var brandNameLabelTopConstraint: NSLayoutConstraint?
    private var containerViewBackgroundColor = UIColor.white

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
        addSubview(containerView)

        containerView.addSubview(logoImageView)
        containerView.addSubview(overlayLogoView)
        containerView.addSubview(discountValueVerticalStackView)
        containerView.addSubview(brandNameLabel)
        containerView.addSubview(subtitleLabel)

        addSubview(pillView)

        containerView.layer.borderColor = "ececec".hexaToUIColor().cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 6.0
        containerView.layer.applyShadow(alpha: 0.1, x: 0, y: 2, blur: 4)                 
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0)
        logoImageViewTopConstraint?.isActive = true

        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 72),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            overlayLogoView.heightAnchor.constraint(equalToConstant: 72),
            overlayLogoView.widthAnchor.constraint(equalTo: overlayLogoView.heightAnchor),
            overlayLogoView.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            overlayLogoView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])

        discountValueVerticalStackViewTopConstraint = discountValueVerticalStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12.0)
        discountValueVerticalStackViewTopConstraint?.isActive = true

        NSLayoutConstraint.activate([
            discountValueVerticalStackView.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor, constant: 8.0),
            discountValueVerticalStackView.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -8.0),
            discountValueVerticalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])

        brandNameLabelTopConstraint = brandNameLabel.topAnchor.constraint(equalTo: discountValueVerticalStackView.bottomAnchor, constant: 8)
        brandNameLabelTopConstraint?.isActive = true

        NSLayoutConstraint.activate([
            brandNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            brandNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            subtitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            subtitleLabel.topAnchor.constraint(equalTo: brandNameLabel.bottomAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])

        NSLayoutConstraint.activate([
            pillView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pillView.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
        ])
    }

    func update(with item: MLBusinessTouchpointsCarouselItemModel) {
        discountValueHorizontalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        discountValueVerticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if let topLabel = item.topLabel {
            discountValueVerticalStackView.addArrangedSubview(discountTopLabel)
            discountTopLabel.text = topLabel
        }

        discountMainLabel.text = item.mainLabel
        discountValueHorizontalStackView.addArrangedSubview(discountMainLabel)

        if let rightLabel = item.rightLabel {
            discountRightLabel.text = rightLabel
            discountValueHorizontalStackView.addArrangedSubview(discountRightLabel)
        }

        brandNameLabel.text = item.title
        subtitleLabel.text = item.subtitle

        if item.title == nil, item.subtitle == nil {
            brandNameLabelTopConstraint?.constant = 0
        } else {
            brandNameLabelTopConstraint?.constant = 8
        }

        if let textColorString = item.textColor {
            let textColor = textColorString.hexaToUIColor()
            discountTopLabel.textColor = textColor
            discountMainLabel.textColor = textColor
            discountRightLabel.textColor = textColor
            brandNameLabel.textColor = textColor
            subtitleLabel.textColor = textColor
        }

        discountValueVerticalStackView.addArrangedSubview(discountValueHorizontalStackView)

        if let logo = item.image {
            logoImageView.setRemoteImage(imageUrl: logo)
        }

        if let pill = item.pill {
            pillView.isHidden = false
            pillView.backgroundColor = pill.format.backgroundColor.hexaToUIColor()
            pillView.tintColor = pill.format.textColor.hexaToUIColor()
            pillView.text = pill.label
            if let icon = pill.icon {
                let imageView = UIImageView()
                imageView.setRemoteImage(imageUrl: icon, customCache: nil) { iconImage in
                    self.pillView.icon = iconImage
                }
            } else {
                pillView.icon = nil
            }
            discountValueVerticalStackViewTopConstraint?.constant = 16
            logoImageViewTopConstraint?.constant = 12
        } else {
            pillView.isHidden = true
            discountValueVerticalStackViewTopConstraint?.constant = 12
            logoImageViewTopConstraint?.constant = 16
        }

        if let backgroundColorString = item.backgroundColor {
            containerViewBackgroundColor = backgroundColorString.hexaToUIColor()
        }
        containerView.backgroundColor = containerViewBackgroundColor
    }

    public func clear() {
        logoImageView.image = nil
        pillView.icon = nil
    }

    private func setHighlighted(with highlightedStatus: Bool) {
        containerView.backgroundColor = highlightedStatus ? "f8f8f8".hexaToUIColor() : containerViewBackgroundColor
    }
}
