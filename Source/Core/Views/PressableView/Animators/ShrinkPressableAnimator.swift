//
//  ShrinkPressableAnimator.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//

import Foundation

public class ShrinkPressableAnimator: PressableAnimator {
    public func animate(view: PressableView, highlighted: Bool) {
        let toTransform: CGAffineTransform = highlighted ? .init(scaleX: 0.96, y: 0.96) : .identity
        let delay = highlighted ? 0.0 : 0.1

        UIView.animate(withDuration: 0.4,
                       delay: delay,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: {
                           view.transform = toTransform
        })
    }
}
