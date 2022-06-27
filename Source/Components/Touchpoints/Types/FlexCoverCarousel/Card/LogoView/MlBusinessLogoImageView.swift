//
//  MlBusinessLogoImageView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 24/06/2022.
//

import Foundation
import MLUI

class MlBusinessLogoImageView: MlBusinessLogoAbstractView {
    var imageProvider: MLBusinessImageProvider
    
    override init(with data: FlexCoverCarouselLogo, imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        super.init(with: data, imageProvider: imageProvider)
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
    
    override func setUpView() {
        addSubview(logoImageView)
        updateViewData()
    }
    
    private func updateViewData() {
        guard let imageName = data.image, let logoStyle = self.data.style ,let width = logoStyle.width, let height = logoStyle.height, let borderWidth = logoStyle.border, let backgroundColor = logoStyle.backgroundColor, let borderColor = logoStyle.borderColor else { return }
        
        imageProvider.getImage(key: imageName) { [weak self] image in
            self?.logoImageView.image = image
        }
        
        guard let logoStyle = self.data.style ,let width = logoStyle.width, let height = logoStyle.height, let borderWidth = logoStyle.border, let backgroundColor = logoStyle.backgroundColor, let borderColor = logoStyle.borderColor else { return }
        
        logoImageView.backgroundColor = backgroundColor.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
        logoImageView.layer.borderColor = borderColor.hexaToUIColor().cgColor
        logoImageView.layer.borderWidth = CGFloat(borderWidth)
        logoImageView.layer.cornerRadius = CGFloat(width)/2
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: CGFloat(width)),
            logoImageView.widthAnchor.constraint(equalToConstant: CGFloat(height)),
        ])
    }
}
