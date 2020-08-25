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
    private weak var overlayView: UIView?
    private var sizeManager: SheetSizeManager
    private let heightManager: SheetHeightManager
    
    private var previousTranslation = CGFloat(0.0)
    private var differenceBelowMin = CGFloat(0.0)
    
    init(contentController: UIViewController, presentingController: UIViewController?, overlayView: UIView, sizeManager: SheetSizeManager, heightManager: SheetHeightManager) {
        self.contentController = contentController
        self.presentingController = presentingController
        self.overlayView = overlayView
        self.sizeManager = sizeManager
        self.heightManager = heightManager
    }
    
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            previousTranslation = 0.0
            differenceBelowMin = 0.0
        }
        
        let min = sizeManager.dimension(for: sizeManager.min())
        
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: view)
            let difference = translation.y - previousTranslation
            if heightManager.getHeight() - differenceBelowMin <= min {
                differenceBelowMin += difference
                contentController?.view.transform = CGAffineTransform(translationX: 0.0, y: .maximum(differenceBelowMin, 0.0))
            } else {
                differenceBelowMin = 0.0
                contentController?.view.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            }
            overlayView?.alpha = 1 - (differenceBelowMin / sizeManager.dimension(for: sizeManager.min()))
            previousTranslation = translation.y
        } else if [UIGestureRecognizer.State.cancelled, UIGestureRecognizer.State.failed, UIGestureRecognizer.State.ended].contains(recognizer.state) {
            if (contentController?.view.transform.ty ?? 0.0) > min * 0.5 {
                presentingController?.dismiss(animated: true)
            } else {
                if contentController?.view.transform != .identity {
                    UIView.animate(withDuration: 0.2,
                                   delay: 0,
                                   options: [.curveEaseOut],
                                   animations: {
                        self.overlayView?.alpha = 1.0
                        self.contentController?.view.transform = .identity
                    })
                }
            }
        }
    }
}

class StretchingPanEffect: PanEffect {
    private var sizeManager: SheetSizeManager
    private let heightManager: SheetHeightManager
    
    private var previousTranslation = CGFloat(0.0)
    private var differenceOverMax = CGFloat(0.0)
    
    init(sizeManager: SheetSizeManager, heightManager: SheetHeightManager) {
        self.sizeManager = sizeManager
        self.heightManager = heightManager
    }
    
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            previousTranslation = 0.0
            differenceOverMax = 0.0
        }
        
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: view)
            let max = sizeManager.dimension(for: sizeManager.max())
            let difference = translation.y - previousTranslation
            if heightManager.getHeight() - difference > max {
                if difference.sign == .minus {
                    differenceOverMax += difference
                    heightManager.setHeight(max + sqrt(differenceOverMax * differenceOverMax.sign()))
                } else {
                    heightManager.setHeight(heightManager.getHeight() - difference)
                }
            } else {
                differenceOverMax = 0.0
            }
            previousTranslation = translation.y
        } else if [UIGestureRecognizer.State.cancelled, UIGestureRecognizer.State.failed, UIGestureRecognizer.State.ended].contains(recognizer.state) {
            heightManager.setHeight(sizeManager.currentDimension)
        }
    }
}

class ResizePanEffect: PanEffect {
    private let sizeManager: SheetSizeManager
    private let heightManager: SheetHeightManager
    private weak var contentController: UIViewController?
    
    private var previousTranslation = CGFloat(0.0)
    
    init(sizeManager: SheetSizeManager, heightManager: SheetHeightManager, contentController: UIViewController) {
        self.sizeManager = sizeManager
        self.heightManager = heightManager
        self.contentController = contentController
    }
    
    func panned(in view: UIView, recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            previousTranslation = 0.0
        }
        
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)
        
        let minHeight = sizeManager.dimension(for: sizeManager.min())
        let maxHeight = sizeManager.dimension(for: sizeManager.max())

        let currentHeight = heightManager.getHeight()
        let currentLocation = currentHeight - CGFloat(contentController?.view.transform.ty ?? 0.0)
        let difference = translation.y - previousTranslation
        
        if (recognizer.state == .began) {
            previousTranslation = 0.0
        } else if (recognizer.state == .changed) {
            if minHeight...(maxHeight * 1.01) ~= currentLocation {
                heightManager.setHeight(max(min(currentHeight - difference, maxHeight), minHeight))
            }
        } else if (recognizer.state == .cancelled || recognizer.state == .failed) {
            heightManager.setHeight(sizeManager.currentDimension)
        } else if (recognizer.state == .ended) {
            let newSize: SheetSize
            if (velocity.y < 0) {
                newSize = sizeManager.ceil(height: heightManager.getHeight())
            } else {
                newSize = sizeManager.floor(height: heightManager.getHeight())
            }

            heightManager.setHeight(sizeManager.dimension(for: newSize))
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
