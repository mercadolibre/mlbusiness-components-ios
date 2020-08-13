//
//  MLBusinessMultipleRowView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 12/08/2020.
//

import Foundation
import MLUI

public protocol MLBusinessMultipleRowViewDelegate: class {
    func multipleRowView(_: MLBusinessMultipleRowView, didSelect item: MLBusinessMultipleRowItemModel)
}

public class MLBusinessMultipleRowView: UIView {
    public weak var delegate: MLBusinessMultipleRowViewDelegate?

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
    private var items: [MLBusinessMultipleRowItemModel]?

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
    
    public func update(with content: [MLBusinessMultipleRowItemModel]) {
        items = content
        multipleRowStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 0...content.count - 1 {
            let containerView = MLBusinessMultipleRowContainerView(frame: .zero)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.index = index
            containerView.pressableDelegate = self
            
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
            containerView.leftAnchor.constraint(equalTo: multipleRowStackView.leftAnchor).isActive = true
            containerView.rightAnchor.constraint(equalTo: multipleRowStackView.rightAnchor).isActive = true
        }
    }
}

extension MLBusinessMultipleRowView: PressableDelegate {
    public func didTap(view: PressableView) {
        guard let items = items, let view = view as? MLBusinessMultipleRowContainerView, let index = view.index else { return }
        delegate?.multipleRowView(self, didSelect: items[index])
    }
}

private class MLBusinessMultipleRowContainerView: PressableView {
    var index: Int?
}
