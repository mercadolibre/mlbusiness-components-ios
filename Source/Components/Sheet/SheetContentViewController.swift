//
//  SheetContentViewController.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 17/08/2020.
//

import UIKit

class SheetContentViewController: UIViewController {

    private(set) var viewController: UIViewController
    private var configuration: SheetConfiguration
    
    private var contentView = UIView()
    private var contentContainerView = UIView()
    private var handleView = UIView()
    
    init(viewController: UIViewController, configuration: SheetConfiguration) {
        self.viewController = viewController
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        setupContentView()
        setupContentContainerView()
        setupChildView()
        setupHandleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculatePreferredContentSize()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calculatePreferredContentSize()
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContentContainerView() {
        contentView.addSubview(contentContainerView)
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        setupCornerRadius(configuration.cornerRadius)
        contentContainerView.layer.masksToBounds = true
    }
    
    private func setupChildView() {
        viewController.willMove(toParent: self)
        addChild(viewController)
        contentContainerView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.leftAnchor.constraint(equalTo: contentContainerView.leftAnchor),
            viewController.view.rightAnchor.constraint(equalTo: contentContainerView.rightAnchor),
            viewController.view.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor)
        ])
        viewController.didMove(toParent: self)
    }
    
    private func setupHandleView() {
        contentView.addSubview(handleView)
        handleView.translatesAutoresizingMaskIntoConstraints = false
        
        let gripHeight: CGFloat = 4.0
        let handleHeight: CGFloat
        
        if #available(iOS 11.0, *) {
            handleHeight = configuration.handle.height
        } else {
            handleHeight = SheetConfiguration.default.handle.height
        }
        
        NSLayoutConstraint.activate([
            handleView.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor),
            handleView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor),
            handleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: max((handleHeight - gripHeight) / 2, 6)),
            handleView.widthAnchor.constraint(equalToConstant: 46.0),
            handleView.heightAnchor.constraint(equalToConstant: gripHeight),
            handleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        handleView.layer.cornerRadius = gripHeight / 2
        handleView.layer.masksToBounds = true
        handleView.backgroundColor = configuration.handle.tint.color()
    }
    
    private func calculatePreferredContentSize() {
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let currentSize = preferredContentSize
        let newSize = viewController.view.systemLayoutSizeFitting(targetSize)
        if newSize != currentSize { preferredContentSize = newSize }
    }
    
    private func setupCornerRadius(_ radius: CGFloat) {
        contentContainerView.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: radius)
    }
}

private extension HandleTint {
    func color() -> UIColor {
        switch self {
        case .light:
        return UIColor.white.withAlphaComponent(0.1)
        case .dark:
        return UIColor.black.withAlphaComponent(0.1)
        }
    }
}
