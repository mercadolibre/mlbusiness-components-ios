//
//  MLBusinessCoverCarouselItemView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 03/11/2020.
//

import UIKit
import MLUI

public class MLBusinessCoverCarouselItemView: UIView {
    private let coverHeight: CGFloat
    
    private lazy var alphaOverlayView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.04)
        view.isHidden = true
        
        return view
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
        return MLBusinessRowView()
    }()
    
    var imageProvider: MLBusinessImageProvider
    
    public init(with imageProvider: MLBusinessImageProvider? = nil, coverHeight: CGFloat = 100) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        self.coverHeight = coverHeight
            
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with item: MLBusinessCoverCarouselItemModel) {
        clear()
        if let cover = item.cover {
            imageProvider.getImage(key: cover) { [weak self] image in
                self?.coverImageView.image = image
            }
        }
        
        if let description = item.description {
            rowView.update(with: description)
        }
    }
    
    public func setHighlighted(_ highlighted: Bool) {
        self.alphaOverlayView.isHidden = !highlighted
    }
    
    public func clear() {
        coverImageView.image = nil
        rowView.prepareForReuse()
    }
    
    private func setupView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        
        addSubview(alphaOverlayView)
        addSubview(coverImageView)
        addSubview(rowView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            alphaOverlayView.topAnchor.constraint(equalTo: topAnchor),
            alphaOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            alphaOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            alphaOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: coverHeight)
        ])
        
        NSLayoutConstraint.activate([
            rowView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            rowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

