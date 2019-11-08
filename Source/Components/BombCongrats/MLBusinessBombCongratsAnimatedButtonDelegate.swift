//
//  MLBusinessBombCongratsAnimatedButtonDelegate.swift
//  MLBusinessComponents
//
//  Created by Javier Quiles on 07/11/2019.
//

import Foundation

@objc public protocol MLBusinessBombCongratsAnimatedButtonDelegate: NSObjectProtocol {
    @objc func didFinishAnimation(_ animatedButton: MLBusinessBombCongratsAnimatedButton)
    @objc func progressButtonAnimationTimeOut()
}
