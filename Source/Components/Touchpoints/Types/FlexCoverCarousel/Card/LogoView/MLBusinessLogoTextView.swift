//
//  MLBusinessLogoTextView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 27/06/2022.
//

import Foundation
import MLUI

class MLBusinessLogoTextView: UIView {
    private let data: FlexCoverCarouselLogo
    
    init(with data: FlexCoverCarouselLogo) {
        self.data = data
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var logoLabelView: UIView = {
        let logoView = UIView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFill
        return logoView
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeSmall))
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpView() {
        addSubview(logoLabelView)
        addSubview(mainLabel)
        updateViewData()
    }
    
    private func updateViewData() {
        guard let labelText = data.label?.text else { return }
                
        mainLabel.text = labelText
        mainLabel.textColor = data.label?.textColor?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.darkGreyColor
        logoLabelView.backgroundColor = data.style?.backgroundColor?.hexaToUIColor() ?? MLStyleSheetManager.styleSheet.whiteColor
        logoLabelView.layer.borderColor = data.style?.borderColor?.hexaToUIColor().cgColor ?? MLStyleSheetManager.styleSheet.greyColor.cgColor
        logoLabelView.layer.borderWidth = CGFloat(data.style?.border ?? 1)
        logoLabelView.layer.cornerRadius = CGFloat(data.style?.width ?? 40)/2
        
        NSLayoutConstraint.activate([
            logoLabelView.heightAnchor.constraint(equalToConstant: CGFloat(data.style?.height ?? 40)),
            logoLabelView.widthAnchor.constraint(equalToConstant: CGFloat(data.style?.width ?? 40)),
            mainLabel.centerXAnchor.constraint(equalTo: logoLabelView.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: logoLabelView.centerYAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 16),
            mainLabel.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
