//
//  MLBusinessPillView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 20/07/2020.
//

import Foundation
import MLUI

public class MLBusinessPillView: UIView {
    public override var tintColor: UIColor! {
        didSet {
            textLabel.textColor = tintColor
            iconImageView.tintColor = tintColor
        }
    }

    public var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
            toggleSizeChange()
        }
    }

    public var icon: UIImage? {
        get {
            return iconImageView.image
        }
        set {
            iconImageView.image = newValue?.withRenderingMode(.alwaysTemplate)
            toggleSizeChange()
        }
    }

    public var fontSize: CGFloat {
        get {
            return textLabel.font.pointSize
        }
        set {
            textLabel.font = textLabel.font.withSize(newValue)
            toggleSizeChange()
        }
    }

    private let textLabel: UILabel = {
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .left
        textLabel.font = MLStyleSheetManager.styleSheet.boldSystemFont(ofSize: CGFloat(9.0))
        textLabel.numberOfLines = 1
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.70
        return textLabel
    }()

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView(frame: .zero)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image?.withRenderingMode(.alwaysTemplate)
        return iconImageView
    }()

    private var imageWidth: NSLayoutConstraint?
    private var pillHeight: CGFloat

    init(with pillHeight: CGFloat = 10) {
        self.pillHeight = pillHeight
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(iconImageView)
        addSubview(textLabel)
    }

    private func setupConstraints() {
        let width = iconImageView.widthAnchor.constraint(equalToConstant: 0)
        imageWidth = width

        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 10.0),
            width,
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 2),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: pillHeight),
        ])

        textLabel.setContentHuggingPriority(.required, for: .vertical)
        textLabel.setContentHuggingPriority(.required, for: .horizontal)
    }

    private func toggleSizeChange() {
        imageWidth?.constant = iconImageView.image == nil ? 0.0 : 10.0
    }
}
