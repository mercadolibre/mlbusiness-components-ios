//
//  PressableView.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 9/9/19.
//

import UIKit

/*
 Create a custom `PressableAnimator` implementation to design custom animations for your press events.
 */
public protocol PressableAnimator {
    func animate(view: PressableView, highlighted: Bool)
}

/*
 Implement the `PressableDelegate` to recieve press events over the view.
 */
public protocol PressableDelegate: class {
    func didTap(view: PressableView)
}

/*
 `PressableView` will forward tap events to it's `pressableDelegate` whenever it is set. `PressableView`
 offers a way to customize its animation whenever the pressing occurs. To do so, create a custom `PressableAnimator`
 implementation and assing it to the view's `pressableAnimator` property.
 */
open class PressableView: UIView {
    public var pressableAnimator: PressableAnimator?
    public weak var pressableDelegate: PressableDelegate?
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        pressableAnimator?.animate(view: self, highlighted: true)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        pressableAnimator?.animate(view: self, highlighted: false)
        pressableDelegate?.didTap(view: self)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        pressableAnimator?.animate(view: self, highlighted: false)
    }
}
