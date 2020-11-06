//
//  MLBusinessCoverCarouselContainerItemView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 03/11/2020.
//

import Foundation

public class MLBusinessCoverCarouselContainerItemView: UIView {
    private let baseView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let containerView: UIView = {
        let containerView = UIView(frame: .zero)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        
        return containerView
    }()
    
    private let coverView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .purple
        
        return image
    }()
    
    private let rowView: MLBusinessRowView = {
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
    
    private func setupView() {
        addSubview(baseView)
        
        translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(containerView)
        
        containerView.addSubview(coverView)
        containerView.addSubview(rowView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: topAnchor),
            baseView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: baseView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor)
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
    
    public func update(with item: MLBusinessCoverCarouselContainerItemModel) {
        rowView.update(with: item.row)
    }
}
