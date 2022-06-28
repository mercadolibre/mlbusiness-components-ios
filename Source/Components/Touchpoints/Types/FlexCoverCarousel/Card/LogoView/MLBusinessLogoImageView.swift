//
//  MlBusinessLogoImageView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 24/06/2022.
//

import Foundation
import MLUI

class MLBusinessLogoImageView: MlBusinessLogoAbstractView {
    let imageProvider = MLBusinessURLImageProvider()
    
    override init(with data: FlexCoverCarouselLogo) {
        super.init(with: data)
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
    
    func setUpView() {
        addSubview(logoImageView)
        updateViewData()
    }
    
    private func updateViewData() {
        guard let imageName = data.image else { return }
        let style = data.style
        
        imageProvider.getImage(key: imageName) { [weak self] image in
            self?.logoImageView.image = image
        }
        
        logoImageView.backgroundColor =  style?.backgroundColor?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
        logoImageView.layer.borderColor = style?.borderColor?.hexaToUIColor().cgColor ?? MLStyleSheetManager.styleSheet.greyColor.cgColor
        logoImageView.layer.borderWidth = CGFloat(style?.border ?? 1)
        logoImageView.layer.cornerRadius = CGFloat(style?.width ?? 40)/2
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: CGFloat(style?.width ?? 40)),
            logoImageView.widthAnchor.constraint(equalToConstant: CGFloat(style?.height ?? 40)),
        ])
    }
}
