//
//  SheetViewController.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 12/08/2020.
//

import UIKit

public class SheetViewController: UIViewController {
    
    public var rootViewController: UIViewController {
        get {
            return contentController.viewController
        }
    }
    
    public var scrollView: UIScrollView? {
        didSet {
            scrollView?.panGestureRecognizer.require(toFail: panGestureRecognizer)
        }
    }
    
    private(set) var overlayView: UIView = UIView()
    
    private var configuration: SheetConfiguration
    private var contentController: SheetContentViewController
    
    private var isPanning: Bool = false
    private var panEffects: [PanEffect] = []
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    private let sizeManager: SheetSizeManager
    private var contentControllerViewHeightConstraint: NSLayoutConstraint!
    
    public init(rootViewController: UIViewController, sizes: [SheetSize] = [.intrinsic], configuration: SheetConfiguration = .default) {
        self.contentController = SheetContentViewController(viewController: rootViewController, configuration: configuration)
        self.sizeManager = SheetSizeManager(sizes: sizes)
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = .overCurrentContext
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupOverlayView()
        setupContentViewController()
        setupPanGestureRecognizer()
        setupTapGestureRecognizer()
        setupPanEffects()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !isPanning else { return }
        contentControllerViewHeightConstraint.priority = .defaultLow
        sizeManager.sheetViewSize = view.bounds.size
        contentControllerViewHeightConstraint.constant = sizeManager.currentDimension
        contentControllerViewHeightConstraint.priority = .defaultHigh
        contentControllerViewHeightConstraint.isActive = true
    }
    
    public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        guard !isPanning else { return }
        contentControllerViewHeightConstraint.priority = .defaultLow
        sizeManager.sheetContentSize = container.preferredContentSize
        contentControllerViewHeightConstraint.constant = sizeManager.currentDimension
        contentControllerViewHeightConstraint.priority = .defaultHigh
        contentControllerViewHeightConstraint.isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .clear
    }
    
    private func setupOverlayView() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(configuration.backgroundAlpha)
        view.addSubview(overlayView)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.leftAnchor.constraint(equalTo: view.leftAnchor),
            overlayView.rightAnchor.constraint(equalTo: view.rightAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
    
    private func setupContentViewController() {
        contentController.willMove(toParent: self)
        addChild(contentController)
        view.addSubview(contentController.view)
        contentControllerViewHeightConstraint = contentController.view.heightAnchor.constraint(equalToConstant: sizeManager.currentDimension)
        NSLayoutConstraint.activate([
            contentController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentController.view.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
        ])
        contentController.didMove(toParent: self)
        sizeManager.sheetContentSize = contentController.preferredContentSize
    }
    
    private func setupPanGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        overlayView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupPanEffects() {
        panEffects.append(ResizePanEffect(sizeManager: sizeManager, heightConstraint: contentControllerViewHeightConstraint, contentController: contentController))
        panEffects.append(VelocityDismissPanEffect(contentController: contentController, presentingController: presentingViewController, sizeManager: sizeManager))
        panEffects.append(StretchingPanEffect(sizeManager: sizeManager, heightConstraint: contentControllerViewHeightConstraint))
        panEffects.append(PullDownPanEffect(contentController: contentController, presentingController: presentingViewController, overlayView: overlayView, sizeManager: sizeManager, heightConstraint: contentControllerViewHeightConstraint))
    }
    
    @objc
    private func panned(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began { isPanning = true }
        panEffects.forEach { $0.panned(in: view, recognizer: recognizer) }
        if [UIGestureRecognizer.State.cancelled, UIGestureRecognizer.State.failed, UIGestureRecognizer.State.ended].contains(recognizer.state) { isPanning = false }
    }
    
    @objc
    private func tapped(_ recongizer: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true)
    }
}

extension SheetViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else { return true }
        guard let scrollView = self.scrollView, scrollView.window != nil else { return true }
        
        let point = gestureRecognizer.location(in: view)
        let pointInChildScrollView = view.convert(point, to: scrollView).y - scrollView.contentOffset.y
        
        guard pointInChildScrollView > 0, pointInChildScrollView < scrollView.bounds.height else { return true }
        
        let topInset = scrollView.contentInset.top
        let velocity = gestureRecognizer.velocity(in: gestureRecognizer.view?.superview)
        
        guard abs(velocity.y) > abs(velocity.x), scrollView.contentOffset.y <= -topInset else { return false }
        
        if velocity.y < 0 {
            let containerHeight = sizeManager.currentDimension
            return sizeManager.dimension(for: sizeManager.max()) > containerHeight && containerHeight < sizeManager.dimension(for: .fullscreen)
        }
        
        return true
    }
}

extension SheetViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SheetPresentingTransitionAnimation()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SheetDismissingTransitionAnimation()
    }
}
