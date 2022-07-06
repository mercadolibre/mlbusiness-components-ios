//
//  MLBusinessFlexCoverCarouselSkeletonItemView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 04/07/2022.
//

import Foundation
import MLUI

public class MLBusinessFlexCoverCarouselSkeletonItemView: UIView {
    private let containerHeight: CGFloat = 89
    
    private lazy var logoView: UIView = {
        let logoView = UIView()
        logoView.clipsToBounds = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.layer.cornerRadius = 20
        logoView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        return logoView
    }()
    
    private lazy var coverView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        return view
    }()
    
    private lazy var mainCardContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        return view
    }()
    
    private lazy var firstRectangleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var secondRectangleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var thirdRectangleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var fourthRectangleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var pillView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func createGradientView() {
        let viewAux = UIView()
        viewAux.frame =  CGRect(x: 0, y: 0, width: 500, height: 104)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewAux.bounds
        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        gradientLayer.opacity = 0.4
        mainCardContainerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        addSubview(coverView)
        addSubview(mainCardContainerView)
        createGradientView()
        addSubview(logoView)
        addSubview(pillView)
        addSubview(firstRectangleView)
        addSubview(secondRectangleView)
        addSubview(thirdRectangleView)
        addSubview(fourthRectangleView)
    }
    
    func setupConstraints(){
        let logoTopAnchorConstraint = logoView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 10)
        let logoBottomAnchorConstraint = logoView.bottomAnchor.constraint(equalTo: firstRectangleView.topAnchor, constant: -21)
        logoTopAnchorConstraint.priority = .defaultHigh
        logoBottomAnchorConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: topAnchor),
            coverView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverView.bottomAnchor.constraint(equalTo: mainCardContainerView.topAnchor),
            
            mainCardContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCardContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCardContainerView.heightAnchor.constraint(equalToConstant: self.containerHeight),
            mainCardContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            logoView.heightAnchor.constraint(equalToConstant: 40),
            logoView.widthAnchor.constraint(equalToConstant: 40),
            logoBottomAnchorConstraint,
            logoTopAnchorConstraint,
            logoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            firstRectangleView.heightAnchor.constraint(equalToConstant: 11),
            firstRectangleView.leadingAnchor.constraint(equalTo: logoView.leadingAnchor),
            firstRectangleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -152),
            firstRectangleView.bottomAnchor.constraint(equalTo: secondRectangleView.topAnchor, constant: -4),
            
            secondRectangleView.heightAnchor.constraint(equalToConstant: 6),
            secondRectangleView.leadingAnchor.constraint(equalTo: firstRectangleView.leadingAnchor),
            secondRectangleView.trailingAnchor.constraint(equalTo: firstRectangleView.trailingAnchor),
            secondRectangleView.bottomAnchor.constraint(equalTo: thirdRectangleView.topAnchor, constant: -4),
            
            thirdRectangleView.heightAnchor.constraint(equalToConstant: 12),
            thirdRectangleView.leadingAnchor.constraint(equalTo: secondRectangleView.leadingAnchor),
            thirdRectangleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
            thirdRectangleView.bottomAnchor.constraint(equalTo: fourthRectangleView.topAnchor, constant: -4),
            
            fourthRectangleView.heightAnchor.constraint(equalToConstant: 12),
            fourthRectangleView.leadingAnchor.constraint(equalTo: thirdRectangleView.leadingAnchor),
            fourthRectangleView.trailingAnchor.constraint(equalTo: thirdRectangleView.trailingAnchor),
            fourthRectangleView.bottomAnchor.constraint(equalTo: pillView.topAnchor, constant: -14),
            
            pillView.heightAnchor.constraint(equalToConstant: 16),
            pillView.widthAnchor.constraint(equalToConstant: 68),
            pillView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            pillView.leadingAnchor.constraint(equalTo: fourthRectangleView.leadingAnchor)
        ])
    }
}
