//
//  MLBusinessCoverCarouselContainerItemView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 03/11/2020.
//

import Foundation

public class MLBusinessCoverCarouselContainerItemView: UIView {
    private let colorForBackground = UIColor.white
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = colorForBackground
        containerView.layer.cornerRadius = 8
        
        return containerView
    }()
    
    private lazy var coverView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .purple
        
        return image
    }()
    
    private lazy var rowView: MLBusinessRowView = {
        let row = MLBusinessRowView()
        
        return row
    }()
    
    public required init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with item: MLBusinessCoverCarouselContainerItemModel) {
        rowView.update(with: item.row)
    }
    
    public func setHighlighted(_ highlighted: Bool) {
        containerView.backgroundColor = highlighted ? colorForBackground.darker() : colorForBackground
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        
        containerView.addSubview(coverView)
        containerView.addSubview(rowView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: containerView.topAnchor),
            coverView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            coverView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            rowView.topAnchor.constraint(equalTo: coverView.bottomAnchor),
            rowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            rowView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}
