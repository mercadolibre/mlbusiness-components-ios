//
//  MlBusinessLogoImageView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 24/06/2022.
//

import Foundation
import MLUI

class MLBusinessLogoImageView: UIView {
    private let imageProvider: MLBusinessImageProvider
    private let data: FlexCoverCarouselLogo
    
    init(with data: FlexCoverCarouselLogo, imageProvider: MLBusinessImageProvider = MLBusinessURLImageProvider()) {
        self.imageProvider = imageProvider
        self.data = data
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var logoImageView: UIImageView = {
        let logoView = UIImageView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFill
        return logoView
    }()
    
    private func setUpView() {
        addSubview(logoImageView)
        updateViewData()
    }
    
    private func updateViewData() {
        guard let imageName = data.image else { return }
        
        imageProvider.getImage(key: imageName) { [weak self] image in
            self?.logoImageView.image = image
        }
        
        logoImageView.backgroundColor =  data.style?.backgroundColor?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
        logoImageView.layer.borderColor = data.style?.borderColor?.hexaToUIColor().cgColor ?? MLStyleSheetManager.styleSheet.greyColor.cgColor
        logoImageView.layer.borderWidth = CGFloat(data.style?.border ?? 1)
        logoImageView.layer.cornerRadius = CGFloat(data.style?.width ?? 40)/2
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: CGFloat(data.style?.width ?? 40)),
            logoImageView.widthAnchor.constraint(equalToConstant: CGFloat(data.style?.height ?? 40)),
        ])
    }
}
