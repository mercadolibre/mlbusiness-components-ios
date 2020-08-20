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
    
    private var contentController: SheetContentViewController
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var panEffects: [PanEffect] = []
    
    private let sizeManager: SheetSizeManager
    private var isPanning: Bool = false
    private var contentControllerViewHeightConstraint: NSLayoutConstraint!
    
    public init(rootViewController: UIViewController, sizes: [SheetSize] = [.intrinsic], configuration: SheetConfiguration = .default) {
        self.contentController = SheetContentViewController(viewController: rootViewController, configuration: configuration)
        self.sizeManager = SheetSizeManager(sizes: sizes)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupContentViewController()
        setupPanGestureRecognizer()
        setupPanEffects()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !isPanning else { return }
        sizeManager.sheetViewSize = view.bounds.size
        contentControllerViewHeightConstraint.constant = sizeManager.currentDimension
        contentControllerViewHeightConstraint.isActive = true
    }
    
    public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        guard !isPanning else { return }
        sizeManager.sheetContentSize = container.preferredContentSize
        contentControllerViewHeightConstraint.constant = sizeManager.currentDimension
        contentControllerViewHeightConstraint.isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .clear
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
    
    private func setupPanEffects() {
        panEffects.append(ResizePanEffect(sizeManager: sizeManager, heightConstraint: contentControllerViewHeightConstraint, contentController: contentController))
        // panEffects.append(VelocityDismissPanEffect(contentController: contentController, presentingController: presentingViewController, sizeManager: sizeManager))
        panEffects.append(StretchingPanEffect(sizeManager: sizeManager, heightConstraint: contentControllerViewHeightConstraint))
        panEffects.append(PullDownPanEffect(contentController: contentController, presentingController: presentingViewController, sizeManager: sizeManager, heightConstraint: contentControllerViewHeightConstraint))
    }
    
    @objc
    private func panned(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began { isPanning = true }
        panEffects.forEach { $0.panned(in: view, recognizer: recognizer) }
        if [UIGestureRecognizer.State.cancelled, UIGestureRecognizer.State.failed, UIGestureRecognizer.State.ended].contains(recognizer.state) { isPanning = false }
    }
}

extension SheetViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollView = self.scrollView, scrollView.window != nil else { return true }
        
        let point = gestureRecognizer.location(in: view)
        let pointInChildScrollView = view.convert(point, to: scrollView).y - scrollView.contentOffset.y
        
        guard pointInChildScrollView > 0, pointInChildScrollView < scrollView.bounds.height else { return true }
        
        let topInset = scrollView.contentInset.top
        let velocity = panGestureRecognizer.velocity(in: panGestureRecognizer.view?.superview)
        
        guard abs(velocity.y) > abs(velocity.x), scrollView.contentOffset.y <= -topInset else { return false }
        
        if velocity.y < 0 {
            let containerHeight = sizeManager.currentDimension
            return sizeManager.dimension(for: sizeManager.max()) > containerHeight && containerHeight < sizeManager.dimension(for: .fullscreen)
        }
        
        return true
    }
}
