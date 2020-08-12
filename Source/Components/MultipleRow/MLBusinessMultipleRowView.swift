//
//  MLBusinessMultipleRowView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 12/08/2020.
//

import Foundation
import MLUI

public class MLBusinessMultipleRowView: UIView {
    private let multipleRowStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.axis = .vertical
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
        
        addSubview(multipleRowStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            multipleRowStackView.topAnchor.constraint(equalTo: topAnchor),
            multipleRowStackView.rightAnchor.constraint(equalTo: rightAnchor),
            multipleRowStackView.leftAnchor.constraint(equalTo: leftAnchor),
            multipleRowStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func update(with content: [MLBusinessRowData]) {
        multipleRowStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 0...content.count - 1 {
            let containerView = UIView(frame: .zero)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let rowView = MLBusinessRowView(with: imageProvider)
            rowView.update(with: content[index])
            containerView.addSubview(rowView)
            
            NSLayoutConstraint.activate([
                rowView.topAnchor.constraint(equalTo: containerView.topAnchor),
                rowView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                rowView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            ])
            
            if index != content.count - 1 {
                let lineView = UIView(frame: .zero)
                lineView.translatesAutoresizingMaskIntoConstraints = false
                lineView.backgroundColor = MLStyleSheetManager.styleSheet.primaryBackgroundColor ?? MLStyleSheetManager.styleSheet.lightGreyColor
                containerView.addSubview(lineView)
                
                NSLayoutConstraint.activate([
                    rowView.bottomAnchor.constraint(equalTo: lineView.topAnchor),
                    lineView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                    lineView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                    lineView.heightAnchor.constraint(equalToConstant: 1.0),
                    lineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    rowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                ])
            }
            multipleRowStackView.addArrangedSubview(containerView)
        }
    }
}
