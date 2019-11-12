//
//  MLBusinessAnimatedButtonDelegate.swift
//  MLBusinessComponents
//
//  Created by Javier Quiles on 07/11/2019.
//

import Foundation

@objc public protocol MLBusinessAnimatedButtonDelegate: NSObjectProtocol {
    @objc func didFinishAnimation(_ animatedButton: MLBusinessAnimatedButton)
    @objc func progressButtonAnimationTimeOut()
    @objc optional func expandAnimationInProgress()
}
