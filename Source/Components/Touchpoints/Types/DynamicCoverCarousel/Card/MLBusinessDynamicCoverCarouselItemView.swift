//
//  MLBusinessDynamicCoverCarouselItemView.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 04/11/2022.
//

import Foundation

class MLBusinessDynamicCoverCarouselItemView: UIView {
    private var content: MLBusinessDynamicCoverCarouselItemModel?
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }
    
    private func setup(){
        backgroundColor = .red
    }
    
    private func setupConstraints(){
        
    }

    
}
