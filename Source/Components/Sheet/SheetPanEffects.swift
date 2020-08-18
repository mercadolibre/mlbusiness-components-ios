//
//  SheetPanEffects.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 18/08/2020.
//

import Foundation

protocol PanEffect {
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer)
}

class VelocityDismissPanEffect: PanEffect {
    private weak var presentingController: UIViewController?
    private weak var contentController: UIViewController?
    private var sizeManager: SheetSizeManager
    
    init(contentController: UIViewController, presentingController: UIViewController?, sizeManager: SheetSizeManager) {
        self.contentController = contentController
        self.presentingController = presentingController
        self.sizeManager = sizeManager
    }
    
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        
        let velocity = recognizer.velocity(in: view)
        let _ = sizeManager.min()
        
        if velocity.y > 2000 {
            presentingController?.dismiss(animated: true)
        }
    }
}

class PullDownPanEffect: PanEffect {
    private weak var presentingController: UIViewController?
    private weak var contentController: UIViewController?
    private var sizeManager: SheetSizeManager
    private let heightConstraint: NSLayoutConstraint
    
    private var previousTranslation = CGFloat(0.0)
    
    init(contentController: UIViewController, presentingController: UIViewController?, sizeManager: SheetSizeManager, heightConstraint: NSLayoutConstraint) {
        self.contentController = contentController
        self.presentingController = presentingController
        self.sizeManager = sizeManager
        self.heightConstraint = heightConstraint
    }
    
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            previousTranslation = 0.0
        }

        let translation = recognizer.translation(in: view)
        let min = sizeManager.dimension(for: sizeManager.min())
        let difference = translation.y - previousTranslation
        
        if recognizer.state == .changed {
            if heightConstraint.constant - difference < min {
                contentController?.view.transform = CGAffineTransform(translationX: 0.0, y: translation.y)
            }
        } else if [UIGestureRecognizer.State.cancelled, UIGestureRecognizer.State.failed, UIGestureRecognizer.State.ended].contains(recognizer.state) {
            if (contentController?.view.transform.ty ?? 0.0) > min * 0.5 {
                presentingController?.dismiss(animated: true)
            } else {
                if contentController?.view.transform != .identity {
                    UIView.animate(withDuration: 0.2,
                                   delay: 0,
                                   options: [.curveEaseOut],
                                   animations: {
                        self.contentController?.view.transform = .identity
                    })
                }
            }
        }
        
        previousTranslation = translation.y
    }
}

class StretchingPanEffect: PanEffect {
    private var sizeManager: SheetSizeManager
    private let heightConstraint: NSLayoutConstraint
    
    private var previousTranslation = CGFloat(0.0)
    
    init(sizeManager: SheetSizeManager, heightConstraint: NSLayoutConstraint) {
        self.sizeManager = sizeManager
        self.heightConstraint = heightConstraint
    }
    
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            previousTranslation = 0.0
        }
        
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: view)
            let max = sizeManager.dimension(for: sizeManager.max())
            
            let difference = translation.y - previousTranslation
            
            if heightConstraint.constant - difference > max {
                heightConstraint.constant += log10(1.0 + difference * difference.sign())
            }
            
            previousTranslation = translation.y
        } else if [UIGestureRecognizer.State.cancelled, UIGestureRecognizer.State.failed, UIGestureRecognizer.State.ended].contains(recognizer.state) {
            heightConstraint.constant = sizeManager.currentDimension
        }
    }
}

class ResizePanEffect: PanEffect {
    private let sizeManager: SheetSizeManager
    private let heightConstraint: NSLayoutConstraint
    
    private var previousTranslation = CGFloat(0.0)
    
    init(sizeManager: SheetSizeManager, heightConstraint: NSLayoutConstraint) {
        self.sizeManager = sizeManager
        self.heightConstraint = heightConstraint
    }
    
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            previousTranslation = 0.0
        }
        
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)
        
        let minHeight = sizeManager.dimension(for: sizeManager.min())
        let maxHeight = sizeManager.dimension(for: sizeManager.max())

        let currentHeight = heightConstraint.constant
        let difference = translation.y - previousTranslation
        
        if (recognizer.state == .began) {
            previousTranslation = 0.0
        } else if (recognizer.state == .changed) {
            if minHeight...maxHeight ~= currentHeight {
                heightConstraint.constant = max(min(currentHeight - difference, maxHeight), minHeight)
            }
        } else if (recognizer.state == .cancelled || recognizer.state == .failed) {
            heightConstraint.constant = sizeManager.currentDimension
        } else if (recognizer.state == .ended) {
            let newSize: SheetSize
            if (velocity.y < 0) {
                newSize = sizeManager.ceil(height: heightConstraint.constant)
            } else {
                newSize = sizeManager.floor(height: heightConstraint.constant)
            }

            heightConstraint.constant = sizeManager.dimension(for: newSize)
            sizeManager.current = newSize
            
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: [.curveEaseOut],
                           animations: {
                view.layoutIfNeeded()
            })
        }
        
        previousTranslation = translation.y
    }
}

private extension CGFloat {
    func sign() -> CGFloat {
        return self > 0 ? 1.0 : -1.0
    }
}
