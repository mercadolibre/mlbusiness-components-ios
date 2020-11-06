//
//  MLBusinessCoverCarouselContainerItemView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 03/11/2020.
//

import Foundation
import MLUI

public class MLBusinessCoverCarouselContainerItemView: UIView {
    private let colorForBackground = UIColor.white
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = colorForBackground
        
        return containerView
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var rowView: MLBusinessRowView = {
        let row = MLBusinessRowView()
        
        return row
    }()
    
    var imageProvider: MLBusinessImageProvider
    
    public required init() {
        imageProvider = MLBusinessURLImageProvider()
            
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with item: MLBusinessCoverCarouselContainerItemModel) {
        imageProvider.getImage(key: item.coverImage) { [weak self] image in
            self?.coverImageView.image = image
        }
        
        rowView.update(with: item.row)
    }
    
    public func setHighlighted(_ highlighted: Bool) {
        containerView.backgroundColor = highlighted ? colorForBackground.darker(by: 80) : colorForBackground
    }
    
    public func clear() {
        coverImageView.image = nil
        rowView.prepareForReuse()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        
        containerView.addSubview(coverImageView)
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
            coverImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            rowView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            rowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            rowView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}
