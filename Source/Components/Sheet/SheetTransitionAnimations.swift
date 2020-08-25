//
//  SheetTransitionAnimations.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 22/08/2020.
//

import Foundation

class SheetPresentingTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private static let duration = TimeInterval(0.2)
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SheetPresentingTransitionAnimation.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let toViewController = transitionContext.viewController(forKey: .to) as? SheetViewController,
            let fromViewController = transitionContext.viewController(forKey: .from),
            let contentView = toViewController.view.subviews.last else { return }
        
        fromViewController.beginAppearanceTransition(false, animated: true)
        toViewController.beginAppearanceTransition(true, animated: true)
        
        containerView.addSubview(toViewController.view)
        
        toViewController.overlayView.alpha = 0.0
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.bounds.height)
        
        UIView.animate(withDuration: SheetPresentingTransitionAnimation.duration,
                        delay: 0.0,
                        options: [.curveEaseOut],
                        animations: {
            toViewController.overlayView.alpha = 1.0
            contentView.transform = .identity
        }, completion: { _ in
            fromViewController.endAppearanceTransition()
            toViewController.endAppearanceTransition()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

class SheetDismissingTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private static let duration = TimeInterval(0.2)
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SheetDismissingTransitionAnimation.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) as? SheetViewController,
            let contentView = fromViewController.view.subviews.last else { return }
        
        fromViewController.beginAppearanceTransition(false, animated: true)
        toViewController.beginAppearanceTransition(true, animated: true)
        
        containerView.addSubview(fromViewController.view)
        
        UIView.animate(withDuration: SheetDismissingTransitionAnimation.duration,
                       delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
            fromViewController.overlayView.alpha = 0.0
            contentView.transform = CGAffineTransform(translationX: 0, y: contentView.bounds.height)
        }) { _ in
            fromViewController.endAppearanceTransition()
            toViewController.endAppearanceTransition()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
